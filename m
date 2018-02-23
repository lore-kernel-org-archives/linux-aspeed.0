From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 23 Feb 2018 10:41:07 +1030
Subject: [PATCH] MAINTAINERS: Update ASPEED entry with details
In-Reply-To: <23b668f1-ab4b-7ef3-ba1e-f252fbba4d1b@linux.intel.com>
References: <20180222050324.21531-1-joel@jms.id.au>
 <1519288786.101739.1279390200.1CD3EC51@webmail.messagingengine.com>
 <23b668f1-ab4b-7ef3-ba1e-f252fbba4d1b@linux.intel.com>
Message-ID: <1519344667.1024159.1280347184.36AD3FEC@webmail.messagingengine.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Haiyue,

On Thu, 22 Feb 2018, at 19:20, Wang, Haiyue wrote:
> Dear Andrew & Joel,
>=20
> Since you are ASPEED BMC experts, any time and interest in eSPI code=20
> review ? I've sent
>=20
> it before, but no more response. Intel recommends eSPI bus than LPC as I =

> know. I just kept
>=20
> the minimal eSPI code which is approved to work well in our real server=20
> boards for two more
>=20
> years. Other part of eSPI driver from ASPEED's SDK=C2=A0 has been removed=
,=20
> because ePSI is a new
>=20
> thing, we only use a small feature set like booting host.
>=20
> We Intel submit this eSPI patch for openbmc upstreaming, hope for your=20
> response. :-)
>=20
> https://patchwork.kernel.org/patch/10166577/
>=20

There are some comments against the v1 that you linked to above, is there a=
 v2 on the lists?

Separately it's better to ping us by replying to the patch itself and putti=
ng us in To/Cc, that way we keep discussions focused on the patch at hand h=
ere.

Cheers,

Andrew
