From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 04 May 2023 13:44:37 +0200
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <ZFOE4wd31hpJh0ro@shell.armlinux.org.uk>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
 <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <ZFOE4wd31hpJh0ro@shell.armlinux.org.uk>
Message-ID: <6ece505b-1075-48e6-9ff9-1673014e5df1@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, May 4, 2023, at 12:11, Russell King (Oracle) wrote:
> On Tue, May 02, 2023 at 02:40:19PM -0500, Rob Herring wrote:
>> I think the only issue remaining is finalizing the mapping of
>> platforms to subdirs. What I have currently is a mixture of SoC
>> families and vendors. The most notable are all the Freescale/NXP
>> platforms, pxa, socfpga, and stm32. It's not consistent with arm64
>> either. Once that's finalized, I still need to go update MAINTAINERS.
>
> I haven't followed this discussion at all, so here's a question.
>
> What does this mean for the _installed_ dtb files? Do they move
> location? If they do, lots is going to break, because there will
> be u-boot configurations and other scripts that assume the flat
> directory structure for the installed dtb files.
>
> I don't think changing the installed dtb structure is acceptable
> at this point in time. It's something that _should_ have been
> thought about when ARM was converted to dtb, it's too late to be
> changing that now.

Rob said earlier that his script does keep a flat directory
for the output of 'make dtbs_install'.

     Arnd
