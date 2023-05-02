From: Christian Hewitt <christianshewitt@gmail.com>
Date: Tue, 2 May 2023 23:01:04 +0100
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
 <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
Message-ID: <AEB0917D-37B0-428B-8FF5-90125BBA7D18@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> On 2 May 2023, at 8:40 pm, Rob Herring <robh+dt@kernel.org> wrote:
> 
> On Tue, May 2, 2023 at 3:15?AM Arnd Bergmann <arnd@arndb.de> wrote:
>> 
>> On Tue, Apr 25, 2023, at 17:57, Rob Herring wrote:
>>> On Tue, Apr 25, 2023 at 2:28?AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> 
>>>> Does your script also cater for .dts files not matching any pattern,
>>>> but including a .dtsi file that does match a pattern?
>>> 
>>> I assume I built everything after moving, but maybe not...
>>> 
>>> That's all just "details". First, we need agreement on a) moving
>>> things to subdirs and b) doing it 1-by-1 or all at once. So far we've
>>> been stuck on a) for being 'too much churn'.
>> 
>> Sorry for missing most of the discussion last week. The script sounds
>> fine to me, the only reason I didn't want to do this in the past is that
>> we had the plan to move platforms out of the kernel tree to an external
>> repository and I wanted to do this platform at a time and also only move
>> each one once. I don't think that is going to happen anytime soon now,
>> so let's just do your script.
>> 
>> Can you send me the script and/or a pull request of the resulting
>> tree based on my soc/dt branch? Everything is merged upstream,
>> and I think git-merge would handle the remaining merges with any
>> other changes in mainline.
> 
> I've dusted off my script and made a branch[1] with the result.
> There's just a couple of fixes needed after the script is run (see the
> top commit). The cross arch includes are all fixed up by the script.
> dtbs_install maintains a flat install. I compared the number of .dtbs
> before and after to check the script.
> 
> I think the only issue remaining is finalizing the mapping of
> platforms to subdirs. What I have currently is a mixture of SoC
> families and vendors. The most notable are all the Freescale/NXP
> platforms, pxa, socfpga, and stm32. It's not consistent with arm64
> either. Once that's finalized, I still need to go update MAINTAINERS.
> 
> Here's the current mapping:
> 
> vendor_map = {
>    'alphascale' : 'alphascale',
>    'alpine' : 'alpine',
>    'artpec' : 'axis',
>    'axm' : 'lsi',
>    'cx9' : 'cnxt',
>    'ecx' : 'calxeda',
>    'highbank' : 'calxeda',
>    'ep7' : 'cirrus',
>    'mxs': 'mxs',
>    'imx23': 'mxs',
>    'imx28': 'mxs',
>    'sun' : 'allwinner',
>    'imx': 'imx',
>    'e6' : 'imx',
>    'e7' : 'imx',
>    'mba6' : 'imx',
>    'ls': 'fsl',
>    'vf': 'fsl',
>    'qcom': 'qcom',
>    'am3' : 'ti',
>    'am4' : 'ti',
>    'am5' : 'ti',
>    'dra' : 'ti',
>    'keystone' : 'ti',
>    'omap' : 'ti',
>    'compulab' : 'ti',
>    'logicpd' : 'ti',
>    'elpida' : 'ti',
>    'motorola' : 'ti',
>    'twl' : 'ti',
>    'da' : 'ti',
>    'dm' : 'ti',
>    'nspire' : 'nspire',
>    'armada' : 'marvell',
>    'dove' : 'marvell',
>    'kirkwood' : 'marvell',
>    'orion' : 'marvell',
>    'mvebu' : 'marvell',
>    'mmp' : 'marvell',
>    'berlin' : 'berlin',
>    'pxa2' : 'pxa',
>    'pxa3' : 'pxa',
>    'pxa' : 'marvell',
>    'arm-' : 'arm',
>    'integ' : 'arm',
>    'mps' : 'arm',
>    've' : 'arm',
>    'aspeed' : 'aspeed',
>    'ast2' : 'aspeed',
>    'facebook' : 'aspeed',
>    'ibm' : 'aspeed',
>    'openbmc' : 'aspeed',
>    'en7' : 'airoha',
>    'at91' : 'microchip',
>    'sama' : 'microchip',
>    'sam9' : 'microchip',
>    'usb_' : 'microchip',
>    'tny_' : 'microchip',
>    'mpa1600' : 'microchip',
>    'animeo_ip' : 'microchip',
>    'aks-cdu' : 'microchip',
>    'ethernut5' : 'microchip',
>    'evk-pro3' : 'microchip',
>    'pm9g45' : 'microchip',
>    'ge86' : 'microchip',
>    'bcm' : 'brcm',
>    'exynos' : 'samsung',
>    's3c' : 'samsung',
>    's5p' : 'samsung',
>    'gemini' : 'gemini',
>    'hi3' : 'hisilicon',
>    'hip' : 'hisilicon',
>    'hisi' : 'hisilicon',
>    'sd5' : 'hisilicon',
>    'hpe' : 'hpe',
>    'intel': 'intel',
>    'mt' : 'mediatek',
>    'meson' : 'meson',

?meson? : ?amlogic?,

^ to match the SoC vendor name (and arm64)

Christian

>    'moxa' : 'moxa',
>    'mstar' : 'mstar',
>    'nuvo' : 'nuvoton',
>    'lpc' : 'lpc',
>    'lan96' : 'microchip',
>    'owl' : 'actions',
>    'ox8' : 'oxsemi',
>    'rda' : 'rda',
>    'rtd' : 'realtek',
>    'r7' : 'renesas',
>    'r8' : 'renesas',
>    'r9' : 'renesas',
>    'emev2' : 'renesas',
>    'sh73a' : 'renesas',
>    'gr-' : 'renesas',
>    'iwg' : 'renesas',
>    'rk' : 'rockchip',
>    'rv11' : 'rockchip',
>    'rockchip' : 'rockchip',
>    'socfpga' : 'socfpga',
>    'stm' : 'stm32',
>    'sti' : 'sti',
>    'st-pin' : 'sti',
>    'ste' : 'st-ericsson',
>    'spear' : 'spear',
>    'axp' : 'allwinner',
>    'tegra' : 'nvidia',
>    'milbeaut' : 'socionext',
>    'uniph' : 'socionext',
>    'vt8500' : 'vt8500',
>    'wm8' : 'vt8500',
>    'xen' : 'xen',
>    'zx' : 'zte',
>    'zynq' : 'xilinx',
> }
> 
> Rob
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git arm-dts-move-v2
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

