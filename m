From: Milton Miller II <miltonm@us.ibm.com>
Date: Wed, 15 Sep 2021 05:15:30 +0000
Subject: [PATCH v2] ARM: dts: aspeed: rainier: Add N_MODE_VREF gpio
In-Reply-To: <CACPK8Xd9MK6oZ=Ac85EkKn7vPvEfqjMKSk=73_R=_16US+6gHQ@mail.gmail.com>
References: <CACPK8Xd9MK6oZ=Ac85EkKn7vPvEfqjMKSk=73_R=_16US+6gHQ@mail.gmail.com>,
 <20210910195417.2838841-1-anoo@linux.ibm.com>
 <CACPK8XfjF+aiEMLocscMEOw8ebKoT2MK8djvv4voyFOBjumXRg@mail.gmail.com>
 <23EB5226-63A1-45AF-A50E-2A9D6DABFC08@linux.ibm.com>
Message-ID: <OFC8E57D8E.A167EBF7-ON00258751.001786E9-00258751.001CE2C3@ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On September 14, 2021, Joel Stanley wrote:
>On Tue, 14 Sept 2021 at 20:46, Adriana Kobylak <anoo@linux.ibm.com>
>wrote:
>> > On Sep 14, 2021, at 3:49 AM, Joel Stanley <joel@jms.id.au> wrote:
>> > On Fri, 10 Sept 2021 at 19:54, Adriana Kobylak
>> > <anoo@linux.ibm.com> wrote:
>> >>
>> >> From: Adriana Kobylak <anoo@us.ibm.com>
>> >>
>> >> The N_MODE_VREF gpio is designed to be used to specify how many
>> >> power
>> >> supplies the system should have (2 or 4).  If enough power
>> >> supplies fail
>> >> so that the system no longer has redundancy (no longer n+1), the
>> >> hardware will signal to the Onboard Chip Controller that the
>> >> system may
>> >> be oversubscribed, and performance may need to be reduced so the
>> >> system
>> >> can maintain it's powered on state. This gpio is on a 9552,
>> >> populate all
>> >> the gpios on that chip for completeness.
>> >>
>> >> Signed-off-by: Adriana Kobylak <anoo@us.ibm.com>
>> >> ---
>> >>
>> >> v2: Update commit message.
>> >>
>> >> arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 103
>+++++++++++++++++++
>> >> 1 file changed, 103 insertions(+)
>> >>
>> >> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
>b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
>> >> index 6fd3ddf97a21..d5eea86dc260 100644
>> >> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
>> >> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
>> >> @@ -1502,6 +1502,109 @@ eeprom at 51 {
>> >>                reg = <0x51>;
>> >>        };
>> >>
>> >> +       pca_pres3: pca9552 at 60 {
>> >> +               compatible = "nxp,pca9552";
>> >> +               reg = <0x60>;
>> >> +               #address-cells = <1>;
>> >> +               #size-cells = <0>;
>> >> +               gpio-controller;
>> >> +               #gpio-cells = <2>;
>> >> +
>> >> +               gpio-line-names =
>> >> +                       "",
>> >> +                       "APSS_RESET_N",
>> >> +                       "", "", "", "",
>> >> +                       "P10_DCM0_PRES",
>> >> +                       "P10_DCM1_PRES",
>> >> +                       "", "",
>> >> +                       "N_MODE_CPU_N",
>> >> +                       "",
>> >> +                       "PRESENT_VRM_DCM0_N",
>> >> +                       "PRESENT_VRM_DCM1_N",
>> >> +                       "N_MODE_VREF",
>> >
>> > Should any (all?) of these names be documented?
>> >
>> >
>INVALID URI REMOVED
>mc_docs_blob_master_designs_device-2Dtree-2Dgpio-2Dnaming.md&d=DwIFaQ
>&c=jf_iaSHvJObTbx-siA1ZOg&r=bvv7AJEECoRKBU02rcu4F5DWd-EwX8As2xrXeO9ZS
>o4&m=JzmffOJA0hX_vgi3n0P-A6l60imZToV7q1U2W2h6xt4&s=14_ACuQWMp-IFlhLQa
>ejLVBN8XVgDnn1_l6336-FBG8&e= 
>>
>> Not sure. Seems the openbmc doc is documenting the gpios for
>> gpiochip0 only?

>AIUI the document is for GPIOs that are exposed to userspace.
>
>It doesn't matter where they're coming from. If they are going to be
>used by a libgpio application, they need to have names, and the names
>should be documented where possible.
>

I agree which gpiochip is just a board wiring consideration and has 
no bearing on the documentation.

However, in the introductory sections in the document clearly says 
the purpose is to establish naming for common (function) GPIOs, and
the justification is by using consistent names across machines code 
will be able to be reused with little to no configuration.  In 
addition it mentions "common" GPIOs must be added to the document in 
the future.  So an evaluation should be made to the likelihood that 
such code reuse can be anticipated.

Most of the names added in this patch are presence detect signals used
to cross check VPD is read into inventory.   I'd expect any such uses to
be configured in an inventory config file listing the name and where the
FRU appears in the Dbus or Redfish model.  I'd argue the names for any 
such gpio would be beyond the present document scope.

The one mentioned in the changelog, N_MODE_VREF, is intended to 
be relayed to the OCC, basically a power management controller in
common in POWER processor chips.  I can see an argument to list this,
but feel it would be in the OpenPOWER specific section unless the 
activation method is exposed in some method that would be common 
to other chipsets.

>...documented in the openbmc design
>doc, such as SLOT6_PRSNT_EN_RSVD, SLOT11_EXPANDER_PRSNT_N, etc.
>
>They should be fixed, if possible.

The scope is clearly use reusable names going forward.  The technical
debt from past naming can be brought down as new uses are added but
we are not renaming every GPIO in every existing platform, and we don't
have the review bandwidth to agree on common names should be added for
all existing signals.

milton
