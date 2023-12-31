class Track {
  final int id;
  final bool readable;
  final String title;
  final String titleShort;
  final String titleVersion;
  final String link;
  final int duration;
  final int rank;
  final bool explicitLyrics;
  final int explicitContentLyrics;
  final int explicitContentCover;
  final String preview;
  final List<Contributor> contributors;
  final String md5Image;
  final Artist artist;
  final Album album;
  final String type;

  Track({
    required this.id,
    required this.readable,
    required this.title,
    required this.titleShort,
    required this.titleVersion,
    required this.link,
    required this.duration,
    required this.rank,
    required this.explicitLyrics,
    required this.explicitContentLyrics,
    required this.explicitContentCover,
    required this.preview,
    required this.contributors,
    required this.md5Image,
    required this.artist,
    required this.album,
    required this.type,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    try {
      return Track(
        id: json['id'] as int? ?? 0,
        readable: json['readable'] as bool? ?? false,
        title: json['title'] as String? ?? '',
        titleShort: json['title_short'] as String? ?? '',
        titleVersion: json['title_version'] as String? ?? '',
        link: json['link'] as String? ?? '',
        duration: json['duration'] as int? ?? 0,
        rank: json['rank'] as int? ?? 0,
        explicitLyrics: json['explicit_lyrics'] as bool? ?? false,
        explicitContentLyrics: json['explicit_content_lyrics'] as int? ?? 0,
        explicitContentCover: json['explicit_content_cover'] as int? ?? 0,
        preview: json['preview'] as String? ?? '',
        contributors: (json['contributors'] as List<dynamic>?)
                ?.map((c) => Contributor.fromJson(c as Map<String, dynamic>))
                .toList() ??
            [],
        md5Image: json['md5_image'] as String? ?? '',
        artist: Artist.fromJson(json['artist'] as Map<String, dynamic>? ?? {}),
        album: Album.fromJson(json['album'] as Map<String, dynamic>? ?? {}),
        type: json['type'] as String? ?? '',
      );
    } catch (e) {
      throw e.toString();
    }
  }
}

class Contributor {
  final int id;
  final String name;
  final String link;
  final String share;
  final String picture;
  final String pictureSmall;
  final String pictureMedium;
  final String pictureBig;
  final String pictureXL;
  final bool radio;
  final String tracklist;
  final String type;
  final String role;

  Contributor({
    required this.id,
    required this.name,
    required this.link,
    required this.share,
    required this.picture,
    required this.pictureSmall,
    required this.pictureMedium,
    required this.pictureBig,
    required this.pictureXL,
    required this.radio,
    required this.tracklist,
    required this.type,
    required this.role,
  });

  factory Contributor.fromJson(Map<String, dynamic> json) {
    return Contributor(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      link: json['link'] as String? ?? '',
      share: json['share'] as String? ?? '',
      picture: json['picture'] as String? ?? '',
      pictureSmall: json['picture_small'] as String? ?? '',
      pictureMedium: json['picture_medium'] as String? ?? '',
      pictureBig: json['picture_big'] as String? ?? '',
      pictureXL: json['picture_xl'] as String? ?? '',
      radio: json['radio'] as bool? ?? false,
      tracklist: json['tracklist'] as String? ?? '',
      type: json['type'] as String? ?? '',
      role: json['role'] as String? ?? '',
    );
  }
}

class Artist {
  final int id;
  final String name;
  final String tracklist;
  final String type;
  final String pictureMedium;
  final String pictureSmall;

  Artist({
    required this.id,
    required this.name,
    required this.tracklist,
    required this.type,
    required this.pictureMedium,
    required this.pictureSmall,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      tracklist: json['tracklist'] as String? ?? '',
      type: json['type'] as String? ?? '',
      pictureMedium: json['picture_medium'] as String? ?? '',
      pictureSmall: json['picture_small'] as String? ?? '',
    );
  }
}

class Album {
  final int id;
  final String title;
  final String cover;
  final String coverSmall;
  final String coverMedium;
  final String coverBig;
  final String coverXL;
  final String md5Image;
  final String tracklist;
  final String type;

  Album({
    required this.id,
    required this.title,
    required this.cover,
    required this.coverSmall,
    required this.coverMedium,
    required this.coverBig,
    required this.coverXL,
    required this.md5Image,
    required this.tracklist,
    required this.type,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      cover: json['cover'] as String? ?? '',
      coverSmall: json['cover_small'] as String? ?? '',
      coverMedium: json['cover_medium'] as String? ?? '',
      coverBig: json['cover_big'] as String? ?? '',
      coverXL: json['cover_xl'] as String? ?? '',
      md5Image: json['md5_image'] as String? ?? '',
      tracklist: json['tracklist'] as String? ?? '',
      type: json['type'] as String? ?? '',
    );
  }
}
