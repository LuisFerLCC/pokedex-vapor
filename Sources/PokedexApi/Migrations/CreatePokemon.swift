//
//  CreatePokemon.swift
//  PokedexApi
//
//  Created by Luis Fernando Maldonado Ramírez on 07/06/2025.
//

/// Migración de base de datos que añade la tabla de Pokémon y sus tuplas
/// iniciales.
///
/// Esta migración crea la tabla `Pokemon` con sus columnas constituyentes en la
/// base de datos. También añade a los primeros 151 Pokémon de la Pokédex
/// oficial.
///
/// Para añadir esta migración a la aplicación, añadimos lo siguiente dentro de
/// la función ``configure(_:)`` en el archivo _configure.swift_:
///
///     app.migrations.add(CreatePokemon())
///
import Fluent

struct CreatePokemon: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("Pokemon")
            .field("id", .int, .identifier(auto: true))
            .field("nombre", .string, .required)
            .field("tipo", .string, .required)
            .field("descripcion", .string, .required)
            .field("imagen", .string, .required)
            .create()

        let pokemon = _data.map { tuple in
            Pokemon(
                id: nil,
                nombre: tuple.0,
                tipo: tuple.1,
                descripcion: tuple.2,
                imagen: tuple.3
            )
        }

        try await database.transaction { database in
            for p in pokemon {
                try await p.save(on: database)
            }
        }
    }

    func revert(on database: any Database) async throws {
        try await database.schema("Pokemon").delete()
    }
}
private let _data = [
    (
        "Bulbasaur", "Planta/Veneno",
        "Bulbasaur es un Pokémon de tipo Planta y Veneno. Es conocido por tener una planta en su espalda que crece a medida que evoluciona.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/4/43/latest/20190406170624/Bulbasaur.png"
    ),
    (
        "Ivysaur", "Planta/Veneno",
        "Ivysaur es la evolución de Bulbasaur. Su planta ha crecido y ahora tiene una flor en su espalda.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/8/86/latest/20190406151903/Ivysaur.png"
    ),
    (
        "Venusaur", "Planta/Veneno",
        "Venusaur es la forma final de Bulbasaur. Su planta ha florecido completamente y es un Pokémon muy poderoso.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/b/be/latest/20160309230456/Venusaur.png"
    ),
    (
        "Charmander", "Fuego",
        "Charmander es un Pokémon de tipo Fuego. Tiene una llama en la punta de su cola que indica su salud y estado de ánimo.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/5/56/latest/20200307023245/Charmander.png"
    ),
    (
        "Charmeleon", "Fuego",
        "Charmeleon es la evolución de Charmander. Su llama se vuelve más intensa y es más agresivo.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/f/fb/latest/20200411222755/Charmeleon.png"
    ),
    (
        "Charizard", "Fuego/Volador",
        "Charizard es la forma final de Charmander. Es un Pokémon poderoso que puede volar y lanzar fuego.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/9/95/latest/20160817212623/Charizard.png"
    ),
    (
        "Squirtle", "Agua", "Rechaza agua por la boca con gran precisión para atacar o defenderse.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/e/e3/latest/20160309230820/Squirtle.png"
    ),
    (
        "Wartortle", "Agua", "Tiene orejas peludas y cola espesa. Vive mucho tiempo.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/d/d7/latest/20200307022248/Wartortle.png"
    ),
    (
        "Blastoise", "Agua", "Tiene cañones de agua en su caparazón que disparan a alta presión.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/4/41/latest/20200411222955/Blastoise.png"
    ),
    (
        "Caterpie", "Bicho",
        "Sus patas le ayudan a escalar muros y árboles. Libera un hedor por sus antenas para repeler enemigos.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/0/05/latest/20230716211653/Caterpie.png"
    ),
    (
        "Metapod", "Bicho", "Aunque está casi inmóvil, dentro de su caparazón está evolucionando.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/6/6b/latest/20200307022334/Metapod.png"
    ),
    (
        "Butterfree", "Bicho/Volador",
        "Sus alas están cubiertas de polvos tóxicos que paralizan a los enemigos.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/9/96/latest/20160703192952/Butterfree.png"
    ),
    (
        "Weedle", "Bicho/Veneno",
        "Tiene un aguijón venenoso en la cabeza. Es común en los bosques.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/d/d6/latest/20200307022415/Weedle.png"
    ),
    (
        "Kakuna", "Bicho/Veneno",
        "Permanece inmóvil mientras evoluciona. Su cuerpo es duro como el acero.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/6/63/latest/20200307022526/Kakuna.png"
    ),
    (
        "Beedrill", "Bicho/Veneno", "Ataca en grupo con los aguijones de sus patas delanteras.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/0/0d/latest/20200307022638/Beedrill.png"
    ),
    (
        "Pidgey", "Normal/Volador", "Este dócil Pokémon vuela bajo buscando insectos que comer.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/b/b7/latest/20200307022723/Pidgey.png"
    ),
    (
        "Pidgeotto", "Normal/Volador",
        "Patrulla su territorio desde el aire. Tiene muy buena vista.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/5/57/latest/20200307022804/Pidgeotto.png"
    ),
    (
        "Pidgeot", "Normal/Volador",
        "Sus alas le permiten volar a una velocidad cercana a la del sonido.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/a/a9/latest/20141214190416/Pidgeot.png"
    ),
    (
        "Rattata", "Normal", "Sus dientes crecen constantemente, por lo que roe cualquier cosa.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/c/c4/latest/20200307022853/Rattata.png"
    ),
    (
        "Raticate", "Normal", "Usa sus enormes colmillos para cortar cosas gruesas como troncos.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/d/d6/latest/20200307022931/Raticate.png"
    ),
    (
        "Spearow", "Normal/Volador",
        "Agresivo por naturaleza. Ataca a cualquier cosa que invada su territorio.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/a/a1/latest/20200307023331/Spearow.png"
    ),
    (
        "Fearow", "Normal/Volador",
        "Tiene un pico largo y delgado. Es capaz de volar durante horas sin descansar.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/4/41/latest/20200307023409/Fearow.png"
    ),
    (
        "Ekans", "Veneno",
        "Se enrolla para descansar o atacar. Puede moverse sigilosamente por el pasto.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/1/11/latest/20230716211828/Ekans.png"
    ),
    (
        "Arbok", "Veneno",
        "El dibujo de su panza intimida a sus enemigos. Cada ejemplar tiene un patrón único.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/4/4d/latest/20230716211756/Arbok.png"
    ),
    (
        "Pikachu", "Eléctrico",
        "Almacena electricidad en sus mejillas. La libera cuando se enoja o se defiende.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/7/77/latest/20150621181250/Pikachu.png"
    ),
    (
        "Raichu", "Eléctrico",
        "Su cola actúa como pararrayos. Puede liberar descargas de hasta 100,000 voltios.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/3/34/latest/20250127090512/Raichu.png"
    ),
    (
        "Sandshrew", "Tierra",
        "Su piel dura y seca lo protege del calor. Se enrosca para defenderse.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/d/df/latest/20230620060651/Sandshrew.png"
    ),
    (
        "Sandslash", "Tierra", "Cuando se enrolla, sus púas se levantan para protegerlo.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/1/13/latest/20230620060657/Sandslash.png"
    ),
    (
        "Nidoran♀", "Veneno",
        "Sus orejas están afinadas para detectar peligros. Ataca con su cuerno tóxico.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/c/c8/latest/20230613021248/Nidoran%E2%99%80.png"
    ),
    (
        "Nidorina", "Veneno",
        "Se vuelve más tranquila al evolucionar. Protege a sus crías con ferocidad.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/7/7a/latest/20230613021105/Nidorino.png"
    ),
    (
        "Nidoqueen", "Veneno/Tierra",
        "Tiene un cuerpo robusto y musculoso. Protege con fiereza a sus crías.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/4/43/latest/20230613021302/Nidoqueen.png"
    ),
    (
        "Nidoran♂", "Veneno",
        "Sus orejas detectan sonidos lejanos. Tiene un cuerno más grande que la hembra.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/6/60/latest/20230613021056/Nidoran%E2%99%82.png"
    ),
    (
        "Nidorino", "Veneno", "Extremadamente agresivo. Su cuerno se endurece y es venenoso.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/7/78/latest/20221107215511/Nidorino.png"
    ),
    (
        "Nidoking", "Veneno/Tierra",
        "Su cola es poderosa. Puede derribar una casa con un solo golpe.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/7/76/latest/20230613021117/Nidoking.png"
    ),
    (
        "Clefairy", "Hada",
        "Se dice que trae buena suerte. Le gusta bailar bajo la luz de la luna.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/d/d2/latest/20230717180740/Clefairy.png"
    ),
    (
        "Clefable", "Hada",
        "Es muy tímido y rara vez se deja ver. Sus pasos son tan ligeros que no hacen ruido.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/d/d5/latest/20230717180839/Clefable.png"
    ),
    (
        "Vulpix", "Fuego", "Tiene seis colas que se separan y se alargan con la edad.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/8/8d/latest/20230613015324/Vulpix.png"
    ),
    (
        "Ninetales", "Fuego",
        "Cada una de sus colas tiene un poder místico. Se dice que vive mil años.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/9/98/latest/20230613015530/Ninetales.png"
    ),
    (
        "Jigglypuff", "Normal/Hada",
        "Canta canciones de cuna con una voz dulce. Su canto adormece al oponente.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/a/af/latest/20150110232910/Jigglypuff.png"
    ),
    (
        "Wigglytuff", "Normal/Hada",
        "Su cuerpo es muy elástico. Se infla como un globo cuando respira profundamente.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/f/f1/latest/20220905202016/Wigglytuff.png"
    ),
    (
        "Zubat", "Veneno/Volador", "Vive en cuevas oscuras. Usa ecolocalización para navegar.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/6/67/latest/20230617053751/Zubat.png"
    ),
    (
        "Golbat", "Veneno/Volador",
        "Se alimenta de la sangre de animales y humanos mientras duermen.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/2/2c/latest/20230716212355/Golbat.png"
    ),
    (
        "Oddish", "Planta/Veneno",
        "Durante el día se entierra y por la noche busca luz para absorber.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/d/d9/latest/20230617054434/Oddish.png"
    ),
    (
        "Gloom", "Planta/Veneno", "Emite un olor desagradable para alejar a sus enemigos.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/5/59/latest/20230617054450/Gloom.png"
    ),
    (
        "Vileplume", "Planta/Veneno",
        "Su flor libera un polen tóxico que puede hacer dormir a su presa.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/3/32/latest/20230617054502/Vileplume.png"
    ),
    (
        "Paras", "Bicho/Planta",
        "Sus hongos crecen sobre su espalda y controlan parcialmente sus acciones.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/e/ee/latest/20230627050525/Paras.png"
    ),
    (
        "Parasect", "Bicho/Planta", "El hongo ha tomado control total sobre el cuerpo de Paras.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/6/62/latest/20230627050534/Parasect.png"
    ),
    (
        "Venonat", "Bicho/Veneno", "Sus grandes ojos le permiten ver en la oscuridad.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/d/d3/latest/20230617054458/Venonat.png"
    ),
    (
        "Venomoth", "Bicho/Veneno",
        "Tiene polvos venenosos en sus alas que paralizan a sus enemigos.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/c/c2/latest/20230617054514/Venomoth.png"
    ),
    (
        "Diglett", "Tierra", "Pasa la mayor parte de su vida bajo tierra. Puede excavar rápido.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/7/7a/latest/20200411223149/Diglett.png"
    ),
    (
        "Dugtrio", "Tierra",
        "Tres Digletts que emergen juntos del suelo. Trabajan en equipo para excavar.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/8/8b/latest/20200411223255/Dugtrio.png"
    ),
    (
        "Meowth", "Normal", "Le encanta coleccionar objetos brillantes y usarlos como juguetes.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/9/99/latest/20160904210550/Meowth.png"
    ),
    (
        "Persian", "Normal", "Es muy elegante y orgulloso. Usa su velocidad para evitar ataques.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/b/b3/latest/20230206193723/Persian.png"
    ),
    (
        "Psyduck", "Agua", "Sufre de constantes dolores de cabeza que liberan poderosas ondas.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/3/32/latest/20230614194705/Psyduck.png"
    ),
    (
        "Golduck", "Agua",
        "Puede nadar a gran velocidad y usar poderes psíquicos cuando está concentrado.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/c/cf/latest/20230617053129/Golduck.png"
    ),
    (
        "Mankey", "Lucha", "Muy agresivo y rápido. Siempre está listo para pelear.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/8/8b/latest/20230620060838/Mankey.png"
    ),
    (
        "Primeape", "Lucha", "Su furia puede hacer que pierda el control y ataque a todo.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/e/e0/latest/20230620060848/Primeape.png"
    ),
    (
        "Growlithe", "Fuego", "Leal y valiente, protege a su entrenador sin dudar.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/b/bb/latest/20211210200407/Growlithe.png"
    ),
    (
        "Arcanine", "Fuego", "Corre a velocidades increíbles y puede cubrir grandes distancias.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/5/50/latest/20150621185018/Arcanine.png"
    ),
    (
        "Poliwag", "Agua",
        "Su cuerpo está cubierto por una piel resbaladiza y su espiral en el vientre indica su salud.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/9/90/latest/20230620061036/Poliwag.png"
    ),
    (
        "Poliwhirl", "Agua",
        "Tiene una piel resbaladiza que le permite moverse rápidamente en el agua y en tierra.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/2/24/latest/20230620061041/Poliwhirl.png"
    ),
    (
        "Poliwrath", "Agua/Lucha",
        "Su musculatura es poderosa, capaz de derribar obstáculos con facilidad.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/8/85/latest/20230620061049/Poliwrath.png"
    ),
    (
        "Abra", "Psíquico", "Puede teletransportarse para escapar de peligros y ataques.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/f/f6/latest/20200411223435/Abra.png"
    ),
    (
        "Kadabra", "Psíquico",
        "Posee poderes psíquicos más fuertes y un cuchillo psíquico que usa en combate.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/b/b0/latest/20220912175715/Kadabra.png"
    ),
    (
        "Alakazam", "Psíquico",
        "Su coeficiente intelectual es extremadamente alto. Puede mover objetos con la mente.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/f/f5/latest/20230716211853/Alakazam.png"
    ),
    (
        "Machop", "Lucha", "Fuerte y resistente, puede levantar pesas muy pesadas.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/2/2b/latest/20230327203924/Machop.png"
    ),
    (
        "Machoke", "Lucha", "Su fuerza física es impresionante. Tiene músculos bien desarrollados.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/c/ca/latest/20200411223604/Machoke.png"
    ),
    (
        "Machamp", "Lucha", "Puede lanzar golpes poderosos con sus cuatro brazos.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/b/bf/latest/20230614200701/Machamp.png"
    ),
    (
        "Bellsprout", "Planta/Veneno", "Suelta un líquido pegajoso para atrapar a sus presas.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/d/d1/latest/20230716212054/Bellsprout.png"
    ),
    (
        "Weepinbell", "Planta/Veneno",
        "Usa su liana para atrapar a las presas y absorber nutrientes.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/f/f9/latest/20230807041154/Weepinbell.png"
    ),
    (
        "Victreebel", "Planta/Veneno",
        "Su liana puede atrapar presas grandes y su boca segrega jugos digestivos.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/5/55/latest/20230807041157/Victreebel.png"
    ),
    (
        "Tentacool", "Agua/Veneno",
        "Sus tentáculos tienen veneno paralizante. Nada cerca de la costa.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/4/43/latest/20230617053650/Tentacool.png"
    ),
    (
        "Tentacruel", "Agua/Veneno", "Controla a sus tentáculos con gran precisión para atacar.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/7/78/latest/20230617053655/Tentacruel.png"
    ),
    (
        "Geodude", "Roca/Tierra", "Pequeño y fuerte. Puede rodar colinas para desplazarse.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/1/12/latest/20230620061559/Geodude.png"
    ),
    (
        "Graveler", "Roca/Tierra", "Sólido y resistente. Puede lanzar rocas a gran velocidad.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/b/b6/latest/20230620061639/Graveler.png"
    ),
    (
        "Golem", "Roca/Tierra", "Su cuerpo es duro como una roca. Puede aplastar con facilidad.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/c/ce/latest/20230620061645/Golem.png"
    ),
    (
        "Ponyta", "Fuego", "Su crin arde como fuego. Corre muy rápido por praderas.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/5/5f/latest/20230628041337/Ponyta.png"
    ),
    (
        "Rapidash", "Fuego", "Su velocidad es tan alta que puede crear tornados con su galope.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/0/01/latest/20201112163200/Rapidash.png"
    ),
    (
        "Slowpoke", "Agua/Psíquico", "Suele estar distraído. Puede detectar ondas psíquicas.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/9/9b/latest/20220613212638/Slowpoke.png"
    ),
    (
        "Slowbro", "Agua/Psíquico",
        "Vive con un Shellder pegado a la cola, que le da poderes psíquicos.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/e/e1/latest/20200604015259/Slowbro.png"
    ),
    (
        "Magnemite", "Eléctrico/Acero",
        "Flota usando campos magnéticos y emite descargas eléctricas.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/8/80/latest/20220228205623/Magnemite.png"
    ),
    (
        "Magneton", "Eléctrico/Acero",
        "Tres Magnemite que se unen para aumentar su poder eléctrico.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/d/d1/latest/20230627210752/Magneton.png"
    ),
    (
        "Farfetchd", "Normal/Volador", "Usa un tallo de puerro como arma y escudo.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/b/b5/latest/20230716211950/Farfetch%27d.png"
    ),
    (
        "Doduo", "Normal/Volador", "Tiene dos cabezas y es muy rápido corriendo.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/9/9c/latest/20160625153314/Doduo.png"
    ),
    (
        "Dodrio", "Normal/Volador", "Tres cabezas que cooperan para correr a gran velocidad.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/1/1a/latest/20200307023207/Dodrio.png"
    ),
    (
        "Seel", "Agua", "Habita en aguas frías y usa su cuerno para atacar.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/f/f1/latest/20230627050530/Seel.png"
    ),
    (
        "Dewgong", "Agua/Hielo", "Combina poder de agua y hielo para defenderse.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/9/9e/latest/20221107215511/Dewgong.png"
    ),
    (
        "Grimer", "Veneno", "Se forma en lugares contaminados y desprende un olor desagradable.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/d/d7/latest/20230627050732/Grimer.png"
    ),
    (
        "Muk", "Veneno", "Su cuerpo está compuesto por una masa tóxica que absorbe todo.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/8/8e/latest/20161104015531/Muk.png"
    ),
    (
        "Shellder", "Agua", "Puede cerrar su caparazón para defenderse.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/6/63/latest/20200720120325/Shellder.png"
    ),
    (
        "Cloyster", "Agua/Hielo",
        "Su caparazón es extremadamente duro y puede lanzar púas afiladas.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/7/71/latest/20200720115806/Cloyster.png"
    ),
    (
        "Gastly", "Fantasma/Veneno", "Un Pokémon gaseoso que asusta a sus presas.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/c/c1/latest/20230716212132/Gastly.png"
    ),
    (
        "Haunter", "Fantasma/Veneno", "Flota en el aire y usa ataques de gas venenoso.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/4/41/latest/20230702054555/Haunter.png"
    ),
    (
        "Gengar", "Fantasma/Veneno", "Muy travieso, puede desaparecer y atacar desde las sombras.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/f/f8/latest/20200428203046/Gengar.png"
    ),
    (
        "Onix", "Roca/Tierra", "Un gigantesco Pokémon serpiente hecho de rocas.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/b/b2/latest/20141214194849/Onix.png"
    ),
    (
        "Drowzee", "Psíquico",
        "Hace que sus presas caigan en sueños para alimentarse de su energía.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/5/5d/latest/20230717181043/Drowzee.png"
    ),
    (
        "Hypno", "Psíquico", "Usa un péndulo para inducir hipnosis.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/0/0e/latest/20230702054123/Hypno.png"
    ),
    (
        "Krabby", "Agua", "Tiene grandes pinzas que usa para defenderse.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/d/da/latest/20230702051914/Krabby.png"
    ),
    (
        "Kingler", "Agua", "Sus pinzas son muy poderosas y pueden aplastar rocas.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/a/a4/latest/20200720120836/Kingler.png"
    ),
    (
        "Voltorb", "Eléctrico",
        "Se parece a una Poké Ball y puede explotar si se siente amenazado.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/8/80/latest/20211210050837/Voltorb.png"
    ),
    (
        "Electrode", "Eléctrico", "Una Poké Ball viviente que puede explotar a voluntad.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/5/52/latest/20220216203321/Electrode.png"
    ),
    (
        "Exeggcute", "Planta/Psíquico", "Un grupo de huevos con poderes psíquicos.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/5/5f/latest/20230716212201/Exeggcute.png"
    ),
    (
        "Exeggutor", "Planta/Psíquico", "Tiene varias cabezas y puede usar ataques psíquicos.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/e/e0/latest/20211115211740/Exeggutor.png"
    ),
    (
        "Cubone", "Tierra", "Lleva el cráneo de su madre y usa un hueso como arma.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/6/65/latest/20230716212229/Cubone.png"
    ),
    (
        "Marowak", "Tierra", "Usa su hueso con gran fuerza para protegerse.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/c/c4/latest/20161104013901/Marowak.png"
    ),
    (
        "Hitmonlee", "Lucha", "Especialista en patadas con gran alcance y fuerza.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/0/0f/latest/20230620061751/Hitmonlee.png"
    ),
    (
        "Hitmonchan", "Lucha", "Maestro en golpes rápidos y potentes.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/7/73/latest/20240408105346/Hitmonchan.png"
    ),
    (
        "Lickitung", "Normal", "Su lengua larga es capaz de atrapar objetos y atacar.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/a/ab/latest/20230627050802/Lickitung.png"
    ),
    (
        "Koffing", "Veneno", "Libera gases tóxicos para defenderse.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/b/b2/latest/20230627050743/Koffing.png"
    ),
    (
        "Weezing", "Veneno", "Libera gases más venenosos y corrosivos.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/8/88/latest/20230627050756/Weezing.png"
    ),
    (
        "Rhyhorn", "Tierra/Roca",
        "Su cuerpo está cubierto de una piel muy dura que le protege de ataques.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/0/01/latest/20230627050821/Rhydon.png"
    ),
    (
        "Rhydon", "Tierra/Roca", "Con un cuerno afilado, puede atravesar casi cualquier cosa.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/f/f0/latest/20221107215511/Rhydon.png"
    ),
    (
        "Chansey", "Normal", "Es muy cariñosa y cuida de otros Pokémon y personas.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/2/2b/latest/20230716212301/Chansey.png"
    ),
    (
        "Tangela", "Planta", "Está cubierta de enredaderas azules que usa para atacar.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/0/03/latest/20200720115145/Tangela.png"
    ),
    (
        "Kangaskhan", "Normal", "Una madre protectora que siempre lleva a su cría en la bolsa.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/3/39/latest/20210906101358/Kangaskhan.png"
    ),
    (
        "Horsea", "Agua", "Lanza chorros de agua a alta presión para defenderse.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/6/6c/latest/20230617052751/Horsea.png"
    ),
    (
        "Seadra", "Agua", "Sus púas afiladas pueden causar heridas profundas.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/2/2d/latest/20230617052757/Seadra.png"
    ),
    (
        "Goldeen", "Agua", "Nada con elegancia y tiene un cuerno afilado para defenderse.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/9/99/latest/20230702052345/Goldeen.png"
    ),
    (
        "Seaking", "Agua", "Posee un cuerno que usa para luchar y proteger su territorio.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/8/8b/latest/20230702052356/Seaking.png"
    ),
    (
        "Staryu", "Agua", "Se comunica con destellos de su núcleo brillante.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/e/e8/latest/20230702052352/Staryu.png"
    ),
    (
        "Starmie", "Agua/Psíquico", "Su núcleo brillante es una fuente de energía misteriosa.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/5/56/latest/20230702052551/Starmie.png"
    ),
    (
        "Mr. Mime", "Psíquico/Hada",
        "Puede crear barreras invisibles y es muy hábil en la pantomima.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/4/4f/latest/20240220190439/Mr._Mime.png"
    ),
    (
        "Scyther", "Bicho/Volador", "Muy rápido y con afiladas garras que corta con facilidad.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/c/c2/latest/20230614202858/Scyther.png"
    ),
    (
        "Jynx", "Hielo/Psíquico",
        "Usa ataques de hielo y poderes psíquicos para confundir a sus enemigos.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/e/e2/latest/20230529045936/Jynx.png"
    ),
    (
        "Electabuzz", "Eléctrico", "Genera electricidad estática para atacar con descargas.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/3/3a/latest/20230617053124/Electabuzz.png"
    ),
    (
        "Magmar", "Fuego", "Su cuerpo está envuelto en llamas, genera calor intenso.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/4/46/latest/20230629034222/Magmar.png"
    ),
    (
        "Pinsir", "Bicho", "Sus grandes pinzas pueden aplastar a sus enemigos.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/b/b4/latest/20230704000232/Pinsir.png"
    ),
    (
        "Tauros", "Normal", "Un toro salvaje muy agresivo y fuerte.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/9/98/latest/20230627205649/Tauros.png"
    ),
    (
        "Magikarp", "Agua", "Aunque débil, puede evolucionar en un poderoso Pokémon.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/0/01/latest/20230617053302/Magikarp.png"
    ),
    (
        "Gyarados", "Agua/Volador", "Temible y agresivo, puede causar gran destrucción.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/d/d7/latest/20150621185114/Gyarados.png"
    ),
    (
        "Lapras", "Agua/Hielo",
        "Amable y inteligente, usado para transportar personas por el agua.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/3/30/latest/20230509165728/Lapras.png"
    ),
    (
        "Ditto", "Normal", "Puede transformarse en cualquier otro Pokémon.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/0/03/latest/20230717180418/Ditto.png"
    ),
    (
        "Eevee", "Normal", "Con múltiples posibles evoluciones, es muy adaptable.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/f/f2/latest/20150621181400/Eevee.png"
    ),
    (
        "Vaporeon", "Agua", "Evolución acuática de Eevee con cuerpo acuoso.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/f/fc/latest/20210627185640/Vaporeon.png"
    ),
    (
        "Jolteon", "Eléctrico", "Evolución eléctrica de Eevee, rápido y con púas eléctricas.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/1/1e/latest/20210627205409/Jolteon.png"
    ),
    (
        "Flareon", "Fuego", "Evolución de fuego de Eevee, con pelaje ardiente.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/1/17/latest/20210628144841/Flareon.png"
    ),
    (
        "Porygon", "Normal", "Un Pokémon virtual hecho de datos digitales.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/2/2d/latest/20190407231904/Porygon.png"
    ),
    (
        "Omanyte", "Roca/Agua", "Un fósil que revive, protegido por un caparazón duro.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/a/a4/latest/20230627205748/Omanyte.png"
    ),
    (
        "Omastar", "Roca/Agua", "Evolución de Omanyte, con pinzas fuertes.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/9/97/latest/20230627205750/Omastar.png"
    ),
    (
        "Kabuto", "Roca/Agua", "Un Pokémon fósil con un caparazón resistente.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/a/a1/latest/20230627205851/Kabuto.png"
    ),
    (
        "Kabutops", "Roca/Agua", "Evolución de Kabuto, con afiladas hojas en lugar de brazos.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/7/72/latest/20230627205851/Kabutops.png"
    ),
    (
        "Aerodactyl", "Roca/Volador", "Un Pokémon fósil muy rápido y agresivo.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/e/e6/latest/20230717180421/Aerodactyl.png"
    ),
    (
        "Snorlax", "Normal", "Duerme todo el día y solo se despierta para comer.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/0/0b/latest/20160904204605/Snorlax.png"
    ),
    (
        "Articuno", "Hielo/Volador", "Un legendario pájaro de hielo con grandes poderes.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/5/52/latest/20160316192008/Articuno.png"
    ),
    (
        "Zapdos", "Eléctrico/Volador", "Un legendario pájaro con control de electricidad.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/d/d8/latest/20160316194916/Zapdos.png"
    ),
    (
        "Moltres", "Fuego/Volador", "Un legendario pájaro de fuego con llamas eternas.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/0/01/latest/20160316201747/Moltres.png"
    ),
    (
        "Dratini", "Dragón", "Un Pokémon dragón en su forma juvenil.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/9/99/latest/20230717180423/Dratini.png"
    ),
    (
        "Dragonair", "Dragón", "Evolución de Dratini, con poderes místicos.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/5/5a/latest/20230717180425/Dragonair.png"
    ),
    (
        "Dragonite", "Dragón/Volador", "Forma final de Dratini, muy fuerte y rápido.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/a/a6/latest/20230518040921/Dragonite.png"
    ),
    (
        "Mewtwo", "Psíquico", "Un Pokémon legendario creado por ingeniería genética.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/d/d3/latest/20190408034831/Mewtwo.png"
    ),
    (
        "Mew", "Psíquico", "Un Pokémon legendario muy raro y poderoso.",
        "https://images.wikidexcdn.net/mwuploads/wikidex/b/bf/latest/20160311010530/Mew.png"
    ),
]
