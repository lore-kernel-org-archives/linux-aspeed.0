From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed, 1 May 2024 16:15:35 -0700
Subject: [PATCH v2 2/2] ARM: dts: aspeed: Add ASRock SPC621D8HM3 BMC
In-Reply-To: <CACPK8Xf6vRKJZHuovMXd2h=nnuKW4m5mcRrfZaTsY987Ai6huQ@mail.gmail.com>
References: <20231120121954.19926-4-zev@bewilderbeest.net>
 <20231120121954.19926-6-zev@bewilderbeest.net>
 <CACPK8Xf6vRKJZHuovMXd2h=nnuKW4m5mcRrfZaTsY987Ai6huQ@mail.gmail.com>
Message-ID: <561b69da-f4e4-49df-ac3e-db0003d549e0@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 29, 2024 at 06:23:27PM PDT, Joel Stanley wrote:
>Hi Zev,
>
>On Mon, 20 Nov 2023 at 22:50, Zev Weiss <zev@bewilderbeest.net> wrote:
>>
>> This is a Xeon board broadly similar (aside from CPU vendor) to the
>> already-support romed8hm3 (half-width, single-socket, ast2500).  It
>> doesn't require anything terribly special for OpenBMC support, so this
>> device-tree should provide everything necessary for basic
>> functionality with it.
>
>We've had these in the aspeed tree for a while, but as I was on leave
>there was no pull request. I'm just putting one together now and
>noticed some unusual looking device tree compatibles:
>
>WARNING: DT compatible string "renesas,isl69269" appears un-documented
>-- check ./Documentation/devicetree/bindings/
>#220: FILE: arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts:181:
>+        compatible = "renesas,isl69269", "isl69269";
>
>WARNING: DT compatible string "isl69269" appears un-documented --
>check ./Documentation/devicetree/bindings/
>#220: FILE: arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts:181:
>+        compatible = "renesas,isl69269", "isl69269";
>
>WARNING: DT compatible string "st,24c128" appears un-documented --
>check ./Documentation/devicetree/bindings/
>#230: FILE: arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts:191:
>+        compatible = "st,24c128", "atmel,24c128";
>
>
>Can you update the patch to be checkpatch clean when applied to v6.9?
>
>Cheers,
>
>Joel

Hi Joel,

After looking at it a bit, I *think* the third warning above (st,24c128) 
is a false positive due to the checkpatch script's ad-hoc grep of the DT 
binding files not picking up on the regex-based compatible definition in 
Documentation/devicetree/bindings/eeprom/at24.yaml -- AFAICT, the 
compatible strings match what's described in the comment in that file 
(and the actual regex itself I believe).

The isl69269 warnings are certainly legitimate though; I'll submit a v3 
with that added to trivial-devices.yml.


Thanks,
Zev

