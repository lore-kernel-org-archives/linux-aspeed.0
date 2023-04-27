From: Matthias Brugger <matthias.bgg@gmail.com>
Date: Thu, 27 Apr 2023 09:37:01 +0200
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
Message-ID: <1cfc224b-f8b0-3143-42d2-188b56368c61@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 25/04/2023 17:57, Rob Herring wrote:
> On Tue, Apr 25, 2023 at 2:28?AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>
>> Hi Rob,
>>
>> On Tue, Apr 25, 2023 at 12:16?AM Rob Herring <robh+dt@kernel.org> wrote:
>>> I have a script[1] that does the conversion written the last time this
>>> came up. Just have to agree on directory names. I think the easiest
>>> would be for Arnd/Olof to run it at the end of a merge window before
>>> rc1.
>>
>> "emev2" and "sh7" are missing for renesas.
> 
> No doubt it's been bitrotting (or I may have missed some).
> 
>> Does your script also cater for .dts files not matching any pattern,
>> but including a .dtsi file that does match a pattern?
> 
> I assume I built everything after moving, but maybe not...
> 
> That's all just "details". First, we need agreement on a) moving
> things to subdirs and b) doing it 1-by-1 or all at once. So far we've
> been stuck on a) for being 'too much churn'.
> 

I think it makes sense to move them and probably the best way to do so is, as 
you proposed: that Arnd or Olof run the script to move them just before -rc1

Regards,
Matthias

> One nice thing with subdirs is 'make CHECK_DTBS=y
> arch/arm/boot/dts/foo/' can build everything for a platform family
> without having to mess with the kconfig. Maybe most folks don't care,
> but I do. My CI job running schema checks looks like this to deal with
> grouping the arm dts files (this list is probably out of date too, but
> less so):
> 
>          if [ "$ARCH" = "arm" ]; then
>              VENDOR_LIST="alphascale alpine artpec aspeed axm bcm cx9
> (ecx|highbank) \
>                efm ep7 imx1 imx23 imx28 imx27 imx5 imx6 imx7 ls vf qcom \
>                (am3|am4|am5|dra|keystone|omap|compulab|logicpd|elpida|motorola-cpcap|da|dm)
> \
>                nspire armada dove kirkwood orion mvebu mmp2 berlin pxa
> (arm-|integ|mps|ve) \
>                (at91|sama|usb_|tny_|mpa1600|animeo_ip|aks-cdu|ethernut5|evk-pro3|pm9g45|ge86)
> \
>                exynos s3c s5p gemini (hisi|hi3|hip) mt meson moxa nuvo
> lpc owl ox8 \
>                (r7|r8|r9|emev2|sh73a|gr-|iwg) (rk|rv11) socfpga stm
> (sti|st-pin) ste \
>                spear (sun|axp) tegra uniph (vt8500|wm8) xen zynq"
>          else
>              VENDOR_LIST=$(ls arch/$ARCH/boot/dts/ | xargs)
>          fi
> 
> Rob
