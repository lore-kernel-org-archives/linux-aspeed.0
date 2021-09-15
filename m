From: Joel Stanley <joel@jms.id.au>
Date: Wed, 15 Sep 2021 02:21:32 +0000
Subject: [PATCH v2] ARM: dts: aspeed: rainier: Add N_MODE_VREF gpio
In-Reply-To: <23EB5226-63A1-45AF-A50E-2A9D6DABFC08@linux.ibm.com>
References: <20210910195417.2838841-1-anoo@linux.ibm.com>
 <CACPK8XfjF+aiEMLocscMEOw8ebKoT2MK8djvv4voyFOBjumXRg@mail.gmail.com>
 <23EB5226-63A1-45AF-A50E-2A9D6DABFC08@linux.ibm.com>
Message-ID: <CACPK8Xd9MK6oZ=Ac85EkKn7vPvEfqjMKSk=73_R=_16US+6gHQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 14 Sept 2021 at 20:46, Adriana Kobylak <anoo@linux.ibm.com> wrote:
>
>
>
> > On Sep 14, 2021, at 3:49 AM, Joel Stanley <joel@jms.id.au> wrote:
> >
> > On Fri, 10 Sept 2021 at 19:54, Adriana Kobylak <anoo@linux.ibm.com> wrote:
> >>
> >> From: Adriana Kobylak <anoo@us.ibm.com>
> >>
> >> The N_MODE_VREF gpio is designed to be used to specify how many power
> >> supplies the system should have (2 or 4).  If enough power supplies fail
> >> so that the system no longer has redundancy (no longer n+1), the
> >> hardware will signal to the Onboard Chip Controller that the system may
> >> be oversubscribed, and performance may need to be reduced so the system
> >> can maintain it's powered on state. This gpio is on a 9552, populate all
> >> the gpios on that chip for completeness.
> >>
> >> Signed-off-by: Adriana Kobylak <anoo@us.ibm.com>
> >> ---
> >>
> >> v2: Update commit message.
> >>
> >> arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 103 +++++++++++++++++++
> >> 1 file changed, 103 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> >> index 6fd3ddf97a21..d5eea86dc260 100644
> >> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> >> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> >> @@ -1502,6 +1502,109 @@ eeprom at 51 {
> >>                reg = <0x51>;
> >>        };
> >>
> >> +       pca_pres3: pca9552 at 60 {
> >> +               compatible = "nxp,pca9552";
> >> +               reg = <0x60>;
> >> +               #address-cells = <1>;
> >> +               #size-cells = <0>;
> >> +               gpio-controller;
> >> +               #gpio-cells = <2>;
> >> +
> >> +               gpio-line-names =
> >> +                       "",
> >> +                       "APSS_RESET_N",
> >> +                       "", "", "", "",
> >> +                       "P10_DCM0_PRES",
> >> +                       "P10_DCM1_PRES",
> >> +                       "", "",
> >> +                       "N_MODE_CPU_N",
> >> +                       "",
> >> +                       "PRESENT_VRM_DCM0_N",
> >> +                       "PRESENT_VRM_DCM1_N",
> >> +                       "N_MODE_VREF",
> >
> > Should any (all?) of these names be documented?
> >
> > https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-naming.md
>
> Not sure. Seems the openbmc doc is documenting the gpios for gpiochip0 only?

AIUI the document is for GPIOs that are exposed to userspace.

It doesn't matter where they're coming from. If they are going to be
used by a libgpio application, they need to have names, and the names
should be documented where possible.

> The gpio names for 9552 in this patch come from the System Workbook, and doesn?t seem the gpios from the existing 9552 that also come from the System Workbook are documented in the openbmc design doc, such as SLOT6_PRSNT_EN_RSVD, SLOT11_EXPANDER_PRSNT_N, etc.

They should be fixed, if possible.

Cheers,

Joel
