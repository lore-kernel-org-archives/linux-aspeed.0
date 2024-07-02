From: Pratyush Yadav <pratyush@kernel.org>
Date: Tue, 02 Jul 2024 14:15:31 -0000
Subject: [PATCH 4/9] mtd: devices: add AT24 eeprom support
In-Reply-To: <20240702-congenial-vigilant-boar-aeae44@houat> (Maxime Ripard's
	message of "Tue, 2 Jul 2024 15:56:52 +0200")
References: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
	<20240701-b4-v6-10-topic-usbc-tcpci-v1-4-3fd5f4a193cc@pengutronix.de>
	<07b701a9-7b52-45b7-8dba-1c25d77cbf15@linaro.org>
	<mafs0ikxnykpr.fsf@kernel.org>
	<20240702-congenial-vigilant-boar-aeae44@houat>
Message-ID: <mafs0ed8byj5z.fsf@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 02 2024, Maxime Ripard wrote:

> On Tue, Jul 02, 2024 at 03:41:52PM GMT, Pratyush Yadav wrote:
>> On Mon, Jul 01 2024, Tudor Ambarus wrote:
>> 
>> > On 7/1/24 2:53 PM, Marco Felsch wrote:
>> >> EEPROMs can become quite large nowadays (>=64K). Exposing such devices
>> >> as single device isn't always sufficient. There may be partitions which
>> >> require different access permissions. Also write access always need to
>> >> to verify the offset.
>> >> 
>> >> Port the current misc/eeprom/at24.c driver to the MTD framework since
>> >> EEPROMs are memory-technology devices and the framework already supports
>> >
>> > I was under the impression that MTD devices are tightly coupled by erase
>> > blocks. But then we see MTD_NO_ERASE, so what are MTD devices after all?
>> 
>> I was curious as well so I did some digging.
>> 
[...]
>> 
>> I also found a thread from 2013 by Maxime Ripard (+Cc) suggesting adding
>> EEPROMs to MTD [1]. The main purpose would have been unifying the EEPROM
>> drivers under a single interface. I am not sure what came of it though,
>> since I can't find any patches that followed up with the proposal.
>
> That discussion led to drivers/nvmem after I started to work on
> some early prototype, and Srinivas took over that work.

So would you say it is better for EEPROM drivers to use nvmem instead of
moving under MTD?

-- 
Regards,
Pratyush Yadav
