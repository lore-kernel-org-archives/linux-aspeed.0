From: Joel Stanley <joel@jms.id.au>
Date: Wed, 20 Dec 2017 13:52:36 +1030
Subject: [PATCH v2 18/19] ARM: dts: aspeed-romulus: Update Romulus system
In-Reply-To: <b8e80861-88c4-da87-a201-ca2eefaa5a94@kaod.org>
References: <20171215062443.23059-1-joel@jms.id.au>
 <20171215062443.23059-19-joel@jms.id.au>
 <b8e80861-88c4-da87-a201-ca2eefaa5a94@kaod.org>
Message-ID: <CACPK8Xdb59ofAnpGt6Uoe9AubTirzvU1=R-4k2y0mfjz09YAjQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2017 at 8:02 PM, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>> +};
>> +
>> +&fmc {
>> +     status =3D "okay";
>> +
>> +     flash at 0 {
>> +             status =3D "okay";
>> +             label =3D "pnor";
>> +             m25p,fast-read;
>> +#include "openbmc-flash-layout.dtsi"
>> +     };
>> +};
>> +
>> +&spi1 {
>> +     status =3D "okay";
>> +
>> +     pinctrl-names =3D "default";
>> +     pinctrl-0 =3D <&pinctrl_spi1_default>;
>> +
>> +     flash at 0 {
>> +             status =3D "okay";
>> +             label =3D "pnor";
>> +             m25p,fast-read;
>>       };
>>  };
>
>
> hmm, the fmc and spi1 bindings were already added in commit 1142aea9ff9d.
>
>
>> @@ -38,6 +101,7 @@
>>               status =3D "okay";
>>               m25p,fast-read;
>>               label =3D "bmc";
>> +#include "openbmc-flash-layout.dtsi"
>
>
> This looks like an extra "fmc" node ?

You're right. It still built and booted too. Good catch.

Cheers,

Joel
