function init_gods_data() {
    global.Gods = [
        // --- PANTHEON 1: STORM & SEA (Storm) ---
        {
            id: 0,
            name: "Susanoo",
            title: "Dios de la Tempestad",
            pantheon: "Storm",
            stats: { strength: 3, speed: 2 },
            dialogs: {
                offer: "El cielo se oscurece y los vientos aúllan mi nombre... Soy Susanoo. He sido desterrado y he matado serpientes de ocho cabezas. ¿Tienes tú la voluntad para caminar en el ojo del huracán?",
                accept: "¡JAJAJA! ¡Excelente! Que mis vientos guíen tu espada y desgarren la carne de tus enemigos. ¡Sé la tormenta que arrasa el mundo!",
                full: "Tu espíritu ya está cargado con demasiadas bendiciones menores. ¿Tienes el coraje para abandonar una antigua protección y abrazar mi tempestad?",
                reject: "¡Necio! Temes mojarte con la lluvia. Desaparece de mi vista antes de que mi rayo te reduzca a cenizas.",
                already: "Ya portas la furia de la tormenta en tu interior. No la desperdicies."
            },
            locked: false
        },
        {
            id: 1,
            name: "Raijin",
            title: "Señor del Trueno",
            pantheon: "Storm",
            stats: { strength: 5, defense: -0.1 }, // Cañón de cristal
            dialogs: {
                offer: "BOOM... BOOM... ¿Oyes mis tambores? Soy Raijin. Puedo darte el poder para pulverizar montañas, pero te advierto: serás volátil como el rayo mismo. ¿Aceptas el poder absoluto a cambio de tu seguridad?",
                accept: "¡KABOOM! ¡Siente la electricidad! ¡Ahora tus golpes resonarán como truenos! ¡Destrúyelos antes de que te toquen!",
                full: "Estás lleno de energía estática barata. ¿Deseas descargar un poder menor para canalizar el verdadero estruendo del cielo?",
                reject: "Aburrido. El silencio es para los muertos. Vete antes de que pierda la paciencia.",
                already: "Tus venas ya chispean con mi electricidad estática. ¡Golpea!"
            },
            locked: false
        },
        {
            id: 2,
            name: "Poseidón",
            title: "Señor de los Océanos",
            pantheon: "Storm",
            stats: { vitality: 5, intelligence: 2 },
            dialogs: {
                offer: "La superficie es caótica, pero las profundidades son eternas. Soy Poseidón. Mis aguas pueden ahogar ejércitos o sostener la vida. ¿Deseas la resistencia inagotable de las mareas?",
                accept: "Las aguas responden a tu llamado. Tu cuerpo ahora fluye con la fuerza del océano; aguanta, resiste y ahoga a quienes se opongan.",
                full: "Tu vaso está lleno, mortal. No puedes contener más poder a menos que vacíes una parte de tu ser. ¿Qué eliges?",
                reject: "Entonces quédate en la orilla, seco y quebradizo como la madera vieja. ¡Fuera!",
                already: "El mar ya fluye a través de ti. Eres uno con la marea."
            },
            locked: false
        },

        // --- PANTHEON 2: RADIANCE (Radiance) ---
        {
            id: 3,
            name: "Amaterasu",
            title: "Diosa del Sol",
            pantheon: "Radiance",
            stats: { intelligence: 6 }, // Full Mana
            dialogs: {
                offer: "La oscuridad se arrastra por los rincones de este mundo, pero mi espejo todo lo revela. Soy Amaterasu. ¿Permitirás que mi luz sagrada queme las sombras y llene tu espíritu de magia infinita?",
                accept: "Brilla con intensidad, guerrero. Que mi luz sea tu escudo y tu espada contra la noche eterna. Tu magia ahora arderá como el mediodía.",
                full: "Tu luz interior es fuerte, pero está dispersa. ¿Deseas reemplazar una antigua alianza para concentrar mi resplandor solar?",
                reject: "Si eliges la sombra, caminarás solo, ciego y frío. Que así sea.",
                already: "Ya eres un faro de esperanza en este mundo oscuro. Sigue iluminando el camino."
            },
            locked: false
        },
        {
            id: 4,
            name: "Freya",
            title: "Diosa de la Fertilidad",
            pantheon: "Radiance",
            stats: { vitality: 3, strength: 1 },
            dialogs: {
                offer: "Los campos de batalla se riegan con sangre para que las flores crezcan más rojas. Soy Freya, y veo una belleza terrible en tu lucha. ¿Deseas que entrelace tu destino con el vigor de la vida misma?",
                accept: "¡Hermoso! Tu vitalidad florecerá como un jardín salvaje en primavera. Que nadie corte tu tallo antes de tiempo, mi valiente.",
                full: "Tu corazón ya está lleno de otros amores. ¿Estás dispuesto a marchitar una vieja y débil alianza para florecer conmigo?",
                reject: "Quien rechaza el amor, camina solo en el frío invierno. Qué desperdicio de vida.",
                already: "Mi bendición ya corre por tus venas. Eres hermoso y letal."
            },
            locked: false
        },
        {
            id: 5,
            name: "Ra",
            title: "Dios Supremo del Sol",
            pantheon: "Radiance",
            stats: { intelligence: 4, strength: 2 },
            dialogs: {
                offer: "Yo navego la barca de los millones de años y expulso a la serpiente del caos cada noche. Soy Ra, el Creador. Mi fuego es autoridad. ¿Te atreves a portar un fragmento del sol de mediodía?",
                accept: "Así sea. Arderás con la autoridad de un Faraón Divino. Que tus enemigos se conviertan en ceniza y polvo bajo tu mirada.",
                full: "Sostienes demasiados ídolos menores en tu alma. ¿Rechazas al Rey de los Cielos por baratijas? Haz espacio o apártate.",
                reject: "Vuelve a la oscuridad de la que viniste. Te destierro de mi luz.",
                already: "Portas el disco solar sobre tu cabeza. Gobierna con sabiduría."
            },
            locked: false
        },

        // --- PANTHEON 3: WAR (War) ---
        {
            id: 6,
            name: "Ares",
            title: "Dios de la Guerra",
            pantheon: "War",
            stats: { strength: 8, vitality: -5 }, // Broken God
            dialogs: {
                offer: "¡SANGRE! ¡HUESOS ROTOS! ¡GRITOS! Eso es lo único que importa. Soy Ares. Te ofrezco una fuerza MONSTRUOSA capaz de partir la tierra, pero tu cuerpo sufrirá el precio de tal violencia. ¿Lo tomas?",
                accept: "¡SÍ! ¡MATALOS A TODOS! ¡NO IMPORTA EL DOLOR, SOLO LA MUERTE! ¡TU FUERZA ES AHORA ABSOLUTA!",
                full: "¿Te acobardas ante el exceso? Tienes demasiadas protecciones débiles. ¡Tira una y acepta la guerra total!",
                reject: "¡COBARDE! ¡DEBILUCHO! ¡NO MERECES MI PODER NI MI TIEMPO!",
                already: "¡LA GUERRA ERES TÚ! ¡SIGUE MATANDO!"
            },
            locked: false
        },
        {
            id: 7,
            name: "Sekhmet",
            title: "Diosa de la Masacre",
            pantheon: "War",
            stats: { strength: 4, speed: 1 },
            dialogs: {
                offer: "Haaa... el olor a hierro en el aire es embriagador. Soy Sekhmet, la Leona que se embriaga con la matanza. Mi sed no tiene fin, y veo que la tuya tampoco. ¿Bebemos juntos de la copa de la guerra?",
                accept: "¡Déjalos sangrar! Destrózalos, desmiémbralos, y ríe mientras el mundo se tiñe de rojo. ¡La cacería comienza ahora!",
                full: "Estás saciado... qué decepción. ¿Acaso no tienes espacio para más odio? Desecha algo inútil y únete a mi carnicería.",
                reject: "Eres una oveja disfrazada de lobo. Vete antes de que seas tú mi próxima presa.",
                already: "Tu pelaje ya está manchado de sangre divina. Bien hecho."
            },
            locked: false
        },
        {
            id: 8,
            name: "Tyr",
            title: "Dios de la Justicia",
            pantheon: "War",
            stats: { strength: 2, defense: 0.15 },
            dialogs: {
                offer: "Muchos hablan de justicia, pero pocos pagan su precio. Soy Tyr. Yo sacrifiqué mi mano en las fauces del lobo para mantener el orden. ¿Qué estás dispuesto a sacrificar tú para asegurar la victoria?",
                accept: "Un pacto sellado con honor. Tu piel se endurecerá como el acero y tu voluntad será inquebrantable. El dolor es el precio de la gloria.",
                full: "Tu espíritu carga con muchas deudas. Para aceptar mi solemne juramento, debes romper otro lazo menor. ¿Tienes la resolución?",
                reject: "Sin sacrificio no hay honor, y sin honor, la victoria es vacía. Largo.",
                already: "Tu balanza está equilibrada y tu espada es justa."
            },
            locked: false
        },

        // --- PANTHEON 4: SHADOWS (Shadows) ---
        {
            id: 9,
            name: "Anubis",
            title: "Señor de la Necrópolis",
            pantheon: "Shadows",
            stats: { vitality: 2, intelligence: 2, speed: 1 },
            dialogs: {
                offer: "Toda vida es un préstamo, y yo vengo a cobrar. Soy Anubis, Guardián de la Balanza. Tu corazón late fuerte, pero el final es inevitable. ¿Aceptas caminar entre los mundos conmigo?",
                accept: "Camina ahora entre los muertos sin miedo. Eres mi ejecutor en la tierra; envía a las almas perdidas hacia mí.",
                full: "Tu alma está cargada con demasiados vínculos terrenales. Debes soltar uno para aceptar el peso de la eternidad.",
                reject: "Tu alma pesa menos que una pluma de avestruz. No eres digno de mi juicio.",
                already: "La muerte camina a tu lado como una vieja amiga."
            },
            locked: false
        },
        {
            id: 10,
            name: "Hel",
            title: "Reina del Inframundo",
            pantheon: "Shadows",
            stats: { vitality: 10, speed: -2 }, // Tanky but Slow
            dialogs: {
                offer: "Ven a mi reino de hielo y niebla... Soy Hel. Te ofrezco una vida eterna y resistente más allá de la comprensión mortal, pero el frío entumecerá tus pasos para siempre. ¿Un trato justo?",
                accept: "Ahora eres mío. Para siempre. Siente el frío de la inmortalidad llenando tus pulmones. Nunca caerás, pero nunca huirás.",
                full: "Ya estás aquí. Las puertas de Helheim se han cerrado tras de ti. No puedes irte.", // Cannot swap logic technically handled by script, but lore-wise fits
                reject: "Nadie escapa de su destino final. Te esperaré.",
                already: "Estamos atados eternamente por el hielo y la muerte."
            },
            locked: false,
            permanent: true
        },
        {
            id: 11,
            name: "Tsukuyomi",
            title: "Dios de la Luna",
            pantheon: "Shadows",
            stats: { intelligence: 3, speed: 2 },
            dialogs: {
                offer: "El mundo es una ilusión bajo la luz del sol. Solo en la oscuridad se ve la verdad. Soy Tsukuyomi. ¿Deseas la claridad fría y la velocidad de la sombra lunar?",
                accept: "Silencioso como la noche, letal como el frío del espacio. Sé el espejo que corta la realidad.",
                full: "¿La luz te ciega y llena tus manos? Debes soltar algo para poder sostener el reflejo de la luna.",
                reject: "La luna te da la espalda. Quédate ciego en tu ignorancia.",
                already: "La noche ya te abraza y guía tus pasos."
            },
            locked: false
        },

        // --- PANTHEON 5: WISDOM (Wisdom) ---
        {
            id: 12,
            name: "Atenea",
            title: "Diosa de la Estrategia",
            pantheon: "Wisdom",
            stats: { defense: 0.25, intelligence: 2 }, // Ultra Defense
            dialogs: {
                offer: "Guerrero, la fuerza bruta sin mente es solo barbarie. Soy Atenea. He visto mil guerras ganadas antes del primer golpe. ¿Deseas mi égida y mi estrategia perfecta?",
                accept: "Una decisión sabia. Tu mente es ahora tu mejor arma, y mi escudo desviará cualquier golpe necio. Pelea con inteligencia.",
                full: "Veo que tu mente está nublada con tácticas inferiores. ¿Deseas olvidar una vieja lección para aprender la estrategia divina?",
                reject: "La necedad te guía a una muerte temprana. No volveré a ofrecerte mi protección.",
                already: "Tu escudo es impenetrable y tu mente afilada."
            },
            locked: false
        },
        {
            id: 13,
            name: "Thoth",
            title: "Escriba de los Dioses",
            pantheon: "Wisdom",
            stats: { intelligence: 5 },
            dialogs: {
                offer: "El universo está hecho de palabras y números. Soy Thoth. Conozco el nombre secreto de todas las cosas. ¿Deseas reescribir tu propio destino con magia pura?",
                accept: "Tu mente se expande más allá del horizonte. Todo está escrito, y ahora tú sostienes la pluma. ¡El conocimiento es poder!",
                full: "¿Desprecias la sabiduría suprema por trucos baratos? Vacía tu mente para que pueda llenarla de verdad.",
                reject: "La ignorancia es una elección, y has elegido ser un necio. Queda en el olvido.",
                already: "Ya posees el conocimiento necesario. Úsalo bien."
            },
            locked: false
        },
        {
            id: 14,
            name: "Odin",
            title: "Padre de Todo",
            pantheon: "Wisdom",
            stats: { strength: 2, intelligence: 2, vitality: 2, speed: 1 },
            dialogs: {
                offer: "He colgado del Yggdrasil y sacrifiqué mi ojo pos la sabiduría. Soy Odin. Lo veo todo, lo sé todo. Te ofrezco un poder supremo y equilibrado, digno de un rey.",
                accept: "Mis cuervos, Hugin y Munin, ahora vuelan sobre ti. Eres perfecto en batalla, mente y cuerpo. No me decepciones.",
                full: "¿Crees saber más que el Padre de Todo? Tienes dones que no te sirven. Haz espacio para la verdadera grandeza.",
                reject: "Tu destino está sellado y es oscuro. No sobrevivirás al Ragnarok sin mí.",
                already: "El Padre de Todo camina contigo. Tu victoria está escrita."
            },
            locked: false
        },

        // --- PANTHEON 6: HUNT (Hunt) ---
        {
            id: 15,
            name: "Hermes",
            title: "Mensajero de los Dioses",
            pantheon: "Hunt",
            stats: { speed: 5 }, // Sonic
            dialogs: {
                offer: "¡Ey, tú! ¡Sí, tú! Vas demasiado lento. Soy Hermes. La vida pasa en un parpadeo. ¿Quieres ser tan rápido que el mundo parezca detenerse?",
                accept: "¡VROOM! ¡Eso es! ¡Ya no te veo! ¡Eres un rayo, un fantasma, una leyenda! ¡Corre y no mires atrás!",
                full: "¿Te pesa el equipaje? Llevas demasiada carga inútil. ¡Suelta algo y aligera tus pies!",
                reject: "Lento... aburrido... tortuga. Me voy antes de que envejezcas.",
                already: "Tus pies tienen alas. Eres intocable."
            },
            locked: false
        },
        {
            id: 16,
            name: "Bastet",
            title: "Diosa Felina",
            pantheon: "Hunt",
            stats: { speed: 3, strength: 2 },
            dialogs: {
                offer: "Shhh... ven aquí, gatito. Soy Bastet. Me gusta jugar con mi comida antes de devorarla. ¿Quieres aprender los secretos de la elegancia letal?",
                accept: "Delicioso. Muévete como la sombra, ataca con garras invisibles y cae siempre de pie. Hazlos sangrar.",
                full: "¿Tus garras están ocupadas? Qué pena. Tendrás que soltar algún juguete viejo para jugar conmigo.",
                reject: "Siseo... vete, perro sarnoso. No eres digno de mi atención.",
                already: "Ya caminas en silencio y tus garras están afiladas."
            },
            locked: false
        },
        {
            id: 17,
            name: "Skadi",
            title: "Diosa del Invierno",
            pantheon: "Hunt",
            stats: { strength: 3, defense: 0.1 },
            dialogs: {
                offer: "El invierno no perdona, y yo tampoco. Soy Skadi. Las montañas son mis huesos y la nieve mi piel. ¿Deseas ser tan duro y despiadado como la ventisca?",
                accept: "Tu corazón ahora es de hielo sólido. Golpea sin remordimiento y soporta el dolor como si nada. La caza ha comenzado.",
                full: "¿Buscas calor en otro lado? Tu espíritu está blando. Endurece tu voluntad y haz espacio para el invierno.",
                reject: "Congelaré tus pasos donde estás. Muere en la nieve.",
                already: "El invierno eterno ya corre por tus venas."
            },
            locked: false
        },

        // --- PANTHEON 7: ORDER (Order) ---
        {
            id: 18,
            name: "Hephaestus",
            title: "Dios de la Forja",
            pantheon: "Order",
            stats: { strength: 3, defense: 0.1 },
            dialogs: {
                offer: "El acero nunca miente, solo la carne falla. Soy Hephaestus. He forjado las armas de los dioses. ¿Quieres que convierta tu cuerpo en un arma viviente?",
                accept: "¡CLANG! ¡Hecho! Golpea duro, como mi martillo en el yunque. Eres una obra maestra de destrucción blindada.",
                full: "¿Tu armadura está completa? Lo dudo. Esa chatarra que llevas no sirve. Tírala y acepta mi acero.",
                reject: "El metal se enfría y se vuelve quebradizo. Igual que tú. Largo.",
                already: "Estás forjado en el fuego divino. Eres irrompible."
            },
            locked: false
        },
        {
            id: 19,
            name: "Horus",
            title: "El Vengador",
            pantheon: "Order",
            stats: { strength: 2, vitality: 2, speed: 1 },
            dialogs: {
                offer: "Yo soy el que restablece el orden. Soy Horus. Vengué a mi padre y reclamé el trono. ¿Buscas la justicia y el poder legítimo para gobernar tu destino?",
                accept: "Vuela alto, halcón. Nada escapa a tu vista y ningún crimen quedará impune. Reina sobre tus enemigos.",
                full: "¿Tu lealtad está dividida? Un rey no puede tener dudas. Abandona lo viejo y reclama tu derecho de nacimiento.",
                reject: "Indigno. Cae en el olvido como los traidores antes que tú.",
                already: "Tus ojos lo ven todo desde las alturas."
            },
            locked: false
        },
        {
            id: 20,
            name: "Hachiman",
            title: "Dios Samurai",
            pantheon: "Order",
            stats: { strength: 4 },
            dialogs: {
                offer: "El camino del guerrero es solitario pero glorioso. Soy Hachiman. El acero de mi katana es mi alma. ¿Juras luchar con honor absoluto y fuerza letal?",
                accept: "Tu espada es la ley. Un solo golpe, una sola muerte. Sé preciso, sé honorable, y sé invencible.",
                full: "¿Buscas atajos sin honor cargando baratijas? Un samurai solo necesita su espada. Haz espacio.",
                reject: "Has roto tu juramento antes de hacerlo. Deshonra para ti y tu familia.",
                already: "Tu estandarte ya ondea alto en el campo de batalla."
            },
            locked: false
        }
    ];

    // Global Managers
    // Important: Use global.StaticAssignments to persist between rooms during the session
    if (!variable_global_exists("StatueAssignments")) {
        global.StatueAssignments = {}; // Map: "RoomName_x_y" -> GodID
    }
    
    // Track active blessings
    if (!variable_global_exists("ActiveBlessings")) {
        global.ActiveBlessings = array_create(3, -1);
    }
    
    // Available gods pool logic
    // We only create this once so we don't reset the pool on room change
    if (!variable_global_exists("AvailableGodsForStatues")) {
        global.AvailableGodsForStatues = ds_list_create();
        for(var i=0; i<21; i++) {
            ds_list_add(global.AvailableGodsForStatues, i);
        }
        ds_list_shuffle(global.AvailableGodsForStatues);
    }
    
    if (!variable_global_exists("RejectedGods")) {
         global.RejectedGods = ds_list_create();
    }
}

function get_statue_god_id(_unique_key) {
    // Check if we already assigned a god to this statue (persistence)
    if (variable_struct_exists(global.StatueAssignments, _unique_key)) {
        return global.StatueAssignments[$ _unique_key];
    }
    
    // If not, assign one from the available list
    if (ds_list_size(global.AvailableGodsForStatues) > 0) {
        var _god_id = global.AvailableGodsForStatues[| 0];
        ds_list_delete(global.AvailableGodsForStatues, 0);
        
        global.StatueAssignments[$ _unique_key] = _god_id;
        return _god_id;
    }
    
    return -1; // No more gods available
}

function get_pantheon_bonus(_pantheon_name) {
     switch(_pantheon_name) {
        case "Storm": return "Cataclismo Natural: 20% prob. rayo/ola";
        case "Radiance": return "Renacimiento Solar: Revivir con 50% HP";
        case "War": return "Sed de Sangre: +1% daño por kill";
        case "Shadows": return "Segador: Ejecuta enemigos < 20% HP";
        case "Wisdom": return "Omniscencia: Mapa revelado";
        case "Hunt": return "Caminante: X2 Velocidad + Inmunidad";
        case "Order": return "Fortaleza: Inmune stun + Reflejo";
    }
    return "";
}
