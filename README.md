<div align="center">
  <h1>lndart.cln_plugin</h1>

  <img src="https://github.com/dart-lightning/icons/raw/main/main/res/mipmap-xxxhdpi/ic_launcher.png" />

  <p>
    <strong> :dart: Dart framework for Core Lightning :dart: </strong>
  </p>

  <h4>
    <a href="https://github.com/dart-lightning">Project Homepage</a>
  </h4>
</div>

A minimal template for projects based on [lndart.cln](https://github.com/dart-lightning/lndart.cln). This should
get you started if you want to develop a core lightning plugin using Dart.

## How to use

Dart can compile a package to a binary in target platform using the `dart compile`

```bash
dart compile exe bin/cln_plugin.dart
```

This will generate an executable in the `bin/` subdirectory. This executable can be used with core lightning using the

```
--plugin = path_to_this_executable
```

## Built with

- [lndart.cln](https://github.com/dart-lightning/lndart.cln)

## Support

If you like the library and want to support it, please considerer to donate with the following system

- [liberapay.com/vincenzopalazzo](https://liberapay.com/vincenzopalazzo)
- [3BQ8qbn8hLdmBKEjt1Hj1Z6SiDsnjJurfU](bitcoin:3BQ8qbn8hLdmBKEjt1Hj1Z6SiDsnjJurfU)
- [Github support](https://github.com/sponsors/vincenzopalazzo)

## License

<div align="center">
  <img src="https://opensource.org/files/osi_keyhole_300X300_90ppi_0.png" width="150" height="150"/>
</div>

Template to write a plugin for core lightning in dart lang.

Copyright (C) 2022 Vincenzo Palazzo vincenzopalazzodev@gmail.com
``

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.