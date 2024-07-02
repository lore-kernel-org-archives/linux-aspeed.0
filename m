From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Jul 2024 13:56:58 -0000
Subject: [PATCH 4/9] mtd: devices: add AT24 eeprom support
In-Reply-To: <mafs0ikxnykpr.fsf@kernel.org>
References: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
 <20240701-b4-v6-10-topic-usbc-tcpci-v1-4-3fd5f4a193cc@pengutronix.de>
 <07b701a9-7b52-45b7-8dba-1c25d77cbf15@linaro.org>
 <mafs0ikxnykpr.fsf@kernel.org>
Message-ID: <20240702-congenial-vigilant-boar-aeae44@houat>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 02, 2024 at 03:41:52PM GMT, Pratyush Yadav wrote:
> On Mon, Jul 01 2024, Tudor Ambarus wrote:
> 
> > On 7/1/24 2:53 PM, Marco Felsch wrote:
> >> EEPROMs can become quite large nowadays (>=64K). Exposing such devices
> >> as single device isn't always sufficient. There may be partitions which
> >> require different access permissions. Also write access always need to
> >> to verify the offset.
> >> 
> >> Port the current misc/eeprom/at24.c driver to the MTD framework since
> >> EEPROMs are memory-technology devices and the framework already supports
> >
> > I was under the impression that MTD devices are tightly coupled by erase
> > blocks. But then we see MTD_NO_ERASE, so what are MTD devices after all?
> 
> I was curious as well so I did some digging.
> 
> The Kconfig help says:
> 
>     Memory Technology Devices are flash, RAM and similar chips, often
>     used for solid state file systems on embedded devices [...]
> 
> The FAQ on the MTD documentation [0] says:
> 
>     Unix traditionally only knew block devices and character devices.
>     Character devices were things like keyboards or mice, that you could
>     read current data from, but couldn't be seek-ed and didn't have a size.
>     Block devices had a fixed size and could be seek-ed. They also happened
>     to be organized in blocks of multiple bytes, usually 512.
> 
>     Flash doesn't match the description of either block or character
>     devices. They behave similar to block device, but have differences. For
>     example, block devices don't distinguish between write and erase
>     operations. Therefore, a special device type to match flash
>     characteristics was created: MTD.
> 
>     So MTD is neither a block nor a char device. There are translations to
>     use them, as if they were. But those translations are nowhere near the
>     original, just like translated Chinese poems.
> 
> And in the section below, it lists some properties of an MTD device:
> 
>     - Consists of eraseblocks.
>     - Eraseblocks are larger (typically 128KiB).
>     - Maintains 3 main operations: read from eraseblock, write to
>       eraseblock, and erase eraseblock.
>     - Bad eraseblocks are not hidden and should be dealt with in
>       software.
>     - Eraseblocks wear-out and become bad and unusable after about 10^3
>       (for MLC NAND) - 10^5 (NOR, SLC NAND) erase cycles.
> 
> This does support the assumption you had about MTD devices being tightly
> coupled with erase block. It also makes it quite clear that an EEPROM is
> not MTD -- since EEPROMs are byte-erasable.
> 
> Of course, the existence of MTD_NO_ERASE nullifies a lot of
> these points. So it seems the subsystem has evolved. MTD_NO_ERASE was
> added by 92cbfdcc3661d ("[MTD] replace MTD_RAM with MTD_GENERIC_TYPE")
> in 2006, but this commit only adds the flag. The functionality of "not
> requiring an explicit erase" for RAM devices has existed since the start
> of the git history at least.
> 
> I also found a thread from 2013 by Maxime Ripard (+Cc) suggesting adding
> EEPROMs to MTD [1]. The main purpose would have been unifying the EEPROM
> drivers under a single interface. I am not sure what came of it though,
> since I can't find any patches that followed up with the proposal.

That discussion led to drivers/nvmem after I started to work on
some early prototype, and Srinivas took over that work.

Maxime
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240702/0aef4ea5/attachment-0001.sig>
