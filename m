Return-Path: <linux-aspeed+bounces-5169-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4E8CA9EBD
	for <linux-aspeed@archiver.kernel.org>; Sun, 11 Oct 2026 16:18:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j2m4Q3Htlz2yY0;
	Mon, 12 Oct 2026 03:18:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791735526;
	cv=none; b=c+IW3GoL+TE3RahfZ8eVh+S3KAIQwkraaXISBUwkXDOBZiqOxm/mpTH8ywTRb9CyCIr8tIJS7I4E8SVPDVo0VKhGgwnTIh5ae7Cyzf8z+vB4vymuRvR9NHVdJL4gTunNNlFALtgnN36LjCfdz5vx+3UA+Wj3vpGj95vdMBPBxW9uDymtmZlPpF+BnNBoQAvIV1HCEIKxoZVqpZ4kHeFPQ0CVLGfEldJt8pFN1xT8UL4wcfgZ+Lu+rclOARhRFVOEHBiVUzikgnLLRBvAIY6KTqwt7yI/muFTfdxkpdob9P56F0A5n+g3cr4vGzD8c3IrYv0d9zfpWn/hBYKrLj/nMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791735526; c=relaxed/relaxed;
	bh=cLevDBr/a6xSK2+ESklMCOJC1LXr8ChWRGeELvbz+GI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkaLonSPmI6Nk9xYDIcTd2rEHemai4z1aY+Ocf85MDicWVlAyIaiF5XwDKEK6iDmXA/qrgonvdLCdocr0TDPc9RcLeFiaG2jW/u5khZ9srAPYaAqtAHndvH6NkPXFXsP4kxqXLam2ViFSGpgCjt9iS5VTNYDZktswI9vzTp+bG4BDF2iqpBTC1nQkNpF2qkp/40/Kl6E+Ycn4wFU44UXatqdaLwuTVAxmrd2Vt8AzGSujpCtAHbPPRI3Z1pqjuS6BiRlU6RyXnI6PJu8ausjGxVcKSQcLsQ4I2I3X0DEBoU/TItQ0ltk9KTcUliOS6f2HC6rvR8e8Pbde7dO6JBcTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Z13SHY47; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Z13SHY47;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j2m4N6p5mz2y7p
	for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Oct 2026 03:18:43 +1100 (AEDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so10456255e9.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 11 Oct 2026 09:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1791735518; x=1792340318; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cLevDBr/a6xSK2+ESklMCOJC1LXr8ChWRGeELvbz+GI=;
        b=Z13SHY47IQLUMEoKC6BIPa6p1ydPn3QWN53kyJkoMl99IacAiHwgfHPt6bCx7jv0X4
         WvXOgIDpH/Owii0JWT3Gn6prI2Q8Mp2KuVe90cyJDZjUD5FZUHMk/jiKs5FCUA9K5muH
         GNB21BE0QfxYJHq7c88K1X45J/PWjSZPtW8YQMy9ePyThn03Pr8QwIHwo4X8SafInP7r
         +6kdDLI1P3ixXVlP7ZoKjn0zqpjbTy5uMQ7MIAQCU1iId18dQO/7vD3cASV/Q7bX3Dqx
         eAHyaGXaW1OGEh6ypzqAzkIunAsgIz3mbCHut0rFN6PkxHKo1LFiLwC4r2uG/PMVmBZJ
         jXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791735518; x=1792340318;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cLevDBr/a6xSK2+ESklMCOJC1LXr8ChWRGeELvbz+GI=;
        b=COLheHytmjUqurHZQeMOFMLluRDzDAp4ukkIB7AbMB4mDDeF0t3tsXE/vGWSja0utO
         Np1nSWqay/3zRgeBm9WaBlyvh5IjVJQMsKFamcIvlKEJl5xbuBSPZ3UG2kYFdC8Gyk4U
         5pBmgeFoM4JQ431T3vEVDdHZpEaW/Gbo1XAnjHxvHjmtznboLIDuvR2+QIVGxPkVkKo0
         KBi3NFNWEVRAiRhq1GaWgvpv43yC90H9VsZmxZwynNJInBesN7XhBxD79WeniTeb0nrZ
         rLKHWMD8d6l+szrjaT8+aYmy319/dmyfKyTmoMH8SQZuwswYs5h4Q8ezGXJpFvCuy4Oh
         7Cyg==
X-Forwarded-Encrypted: i=1; AKwUvBxrx4Mo+wB0r/zkND0ffQ9YM75iR7n2hZNHyyMAAM8JCMtQQy2mAjK+nvBEQz6pjtO4VySk/8DY0qZsS4M=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJWCk930Nsx1z2cAkmMmEKg3EtIWyCCEfph6khAEDHgtTmKnGwK
	SZH4eaCKnwV0EqdwW0DlN1jvTnetMqSpRDPmWIK1AFBjgPPbs+/tBeDToCOivGClTcA=
X-Gm-Gg: AYBFou1A+nsAlPc4xRnob3NO2IMK6aNNYKzTnJ3q14HM0LLW0cWYXa++gaP0iSTHHV+
	hjwXCw0l+TkaBmzijUJ7VbnTRZnmaeLBIPkNRmwrYIKVmMeNTFJe6Ced1ThcB39P5fzzusQKWlq
	yl0kmFMvfgxBH8P1p1BAa12BjypPX1au9hbCMXn+lNMHDUr2cUsVEHQaw5mA7NK3UCVuYOhFXjl
	/lZrpefG/0QV3disM6ACEAaluGz8bA1BdjYr+9GxkSx8Wng5yMgd2VtZ219jvLoCxKVn6Y443Zo
	VB5V6P7kOcpbsi+RsfGJ/Ip0fpy9xyIa0D0NgZvnUIFHYtAHEjiqV5yYFZBfcTiOZM2NYk62oXR
	hI4FU9SvcOQobTGYcKpEB1Acxmw/SgSsJtqQ3lnKcrxzG02YkIskLgPSI700/qk3nDrfNIepi6d
	ahaPLn5V7jc1JlJPHFHasGJZebmG/LFYDjfEyWlnkFhg6Vh4eJb/asZuwMdNY7Gdrk+idsiTje0
	cCB/IwfbLhDe4ql1q4VecEpHbkILguDlv9jBQ0XkA8mzA92
X-Received: by 2002:a05:600c:3c89:b0:49f:bd3c:bc18 with SMTP id 5b1f17b1804b1-4a18e49242fmr134428835e9.19.1791735517494;
        Sun, 11 Oct 2026 09:18:37 -0700 (PDT)
Received: from ?IPV6:2001:9e8:2cc:2101:aa59:e08:7cab:1f61? ([2001:9e8:2cc:2101:aa59:e08:7cab:1f61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18c1e33d2sm302192575e9.0.2026.10.11.09.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2026 09:18:37 -0700 (PDT)
Message-ID: <e2e3d98b-9a89-4845-aa7d-0e23a1d95f70@9elements.com>
Date: Sun, 11 Oct 2026 18:18:35 +0200
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_pci: Add support for ASPEED BMC VUARTs over
 PCIe
To: Phil Rosenthal <phil@phil.gs>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Corey Minyard <corey@minyard.net>,
 "openipmi-developer@lists.sourceforge.net"
 <openipmi-developer@lists.sourceforge.net>, Andy Shevchenko
 <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 Ninad Palsule <ninad@linux.ibm.com>, Andrew Lunn <andrew@lunn.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 =?UTF-8?Q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>
References: <20261008-aspeed-vuart-v1-1-d2be17c99cd7@phil.gs>
 <CAHp75VdiO9tPX2vLqsX2-omNvs-YjkWWD-HOiqyDSzpJrrZ_5w@mail.gmail.com>
 <60996F21-A12C-4FCC-9D5E-9D188A4ADBEA@phil.gs>
 <CAHp75VdmMwXRQFKLG8c4yAsVA5=eFZA3jagtMGb-qVswcQ88Wg@mail.gmail.com>
 <2F1931BE-F0F0-4F21-BED4-67080A40AEA9@phil.gs>
Content-Language: en-US
From: Tan Siewert <tan.siewert@9elements.com>
In-Reply-To: <2F1931BE-F0F0-4F21-BED4-67080A40AEA9@phil.gs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/10/26 12:47 PM, Phil Rosenthal wrote:
> On Sat, Oct 10, 2026, Andy Shevchenko wrote:
>> I will look into this deeper when I return from the LPC 2026 trip, but
>> what you are doing sounds really wrong.

*snip*

> One correction to v1: it said interrupts don't work on this device.
> They do. The board just uses a different MSI vector than the one I
> tried, and which vector it is depends on the BMC firmware.

Disclaimer: It's been a while since I worked on this driver, so please 
take my words with a grain of salt.

Correct, the BMC firmware sets its SIRQ statically. As far as we have 
seen on devices that use VUART over PCIe, they used the vendor 
recommended interrupts which are 0 and 1 (vectors 16 and 17 on the host 
side).

> In a separate driver I can find the vector at probe time and fall back
> to polling if there isn't one. That makes the console about 7 times faster
> than polling (about 15 KB/s instead of 2 KB/s), and the CPU no longer has to
> poll the port. I couldn't do that cleanly as a quirk in 8250_pci.c, but
> it would work the same in a driver for the whole device.
> 
> Grégoire Layet (Cc'd) has a series for the same device [1]
> It adds an MFD driver, drivers/mfd/aspeed-pci-core.c, that registers the
> serial ports as a child device. But it only binds when the BMC runs a modified
> OpenBMC, which changes the device's class code and puts the serial port
> interrupts on fixed MSI vectors.

@Grégoire do you remember why `8250_aspeed_vuart` sets the PCIe class 
code to `0xff000000`?

The reason for having an MFD driver instead of a separate 8250 serial 
driver is simple: We want to have the ability to support multiple 
devices like KCS over PCIe or Mailbox too, which uses the same BARs.
There was a discussion about this already in previous versions of the 
series that Grégoire has proposed (I think it was v2) [0].

> With stock firmware, like on this board, it doesn't bind at all.
> So there are two ways forward:
> 
> 1. A separate 8250 driver for stock firmware, as I proposed.
> 
> 2. Extend Grégoire's driver so it also handles stock firmware: match the
>     KCS class code as well, and find the MSI vector at probe time instead
>     of assuming it. I'd work that out with Grégoire and send it on top of
>     his series, together with the ipmi_si change. KCS would stay with
>     ipmi_si's ACPI path either way.

If you found a way to find the correct MSI vectors at probe time (with 
other features like KCS or Mailbox enabled), please propose it so. 
AFAICR we've looked into this and haven't found a suitable solution for it.

[0] 
https://lore.kernel.org/all/cover.1780929570.git.gregoire.layet@9elements.com/

Cheers,
Tan

> 
> I'm happy with either. Please let me know which you'd prefer, and I'll
> wait for that before sending anything new.
> 
> [1] https://lore.kernel.org/r/20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com
> 
> Thanks,
> Phil
> 
> 
>> On Oct 10, 2026, at 4:10 AM, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>
>> On Fri, Oct 9, 2026 at 4:45 PM Phil Rosenthal <phil@phil.gs> wrote:
>>>> On Oct 9, 2026, at 4:57 AM, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>>>
>>>> There is already a driver for this 8250_aspeed_vuart.c. Please, do not
>>>> add new quirks to 8250_pci.c.
>>>
>>> Thanks for the review.
>>>
>>> As far as I can tell, 8250_aspeed_vuart.c drives the other end of the
>>> VUART. It is an OF platform driver (aspeed,ast2400-vuart and
>>> aspeed,ast2500-vuart) for Linux running on the BMC itself: it depends on
>>> ARCH_ASPEED, has no PCI ID table, and programs the BMC-side GCRA/GCRB
>>> registers (VUART enable, host SIRQ routing), which the host cannot
>>> reach.
>>>
>>> This patch is for the host side. There the VUART appears as 16550
>>> registers in BAR1 of the BMC's PCIe function (1a03:2402), and nothing
>>> binds that function today,
>>
>> In the comments to the patch you told that ipmi_si matches it.
>>
>>> so SOL goes quiet once Linux starts. I don't
>>> see a way to reuse 8250_aspeed_vuart.c for it, but please correct me if
>>> I'm missing something.
>>>
>>> Understood about 8250_pci.c. Would a separate driver be acceptable,
>>> e.g. drivers/tty/serial/8250/8250_aspeed_pci.c using 8250_pcilib, along
>>> the lines of 8250_pericom.c? It would do the same as this patch: find
>>> the VUARTs the BMC has enabled in BAR1 and register them as polled
>>> ports. If that works for you, I'll send it as v2.
>>
>> What has Pericom to do with all this?
>>
>> ...
>>
>> I will look into this deeper when I return from the LPC 2026 trip, but
>> what you are doing sounds really wrong.
>>
>> -- 
>> With Best Regards,
>> Andy Shevchenko
> 


-- 
Tan Siewert
(they/she)

9elements GmbH, Kortumstraße 19-21, 44787 Bochum, Germany
Email:  tan.siewert@9elements.com
Phone:  +49 234 68 94 188

Sitz der Gesellschaft: Bochum
Handelsregister: Amtsgericht Bochum, HRB 17519
Geschäftsführung: Sebastian Deutsch, Eray Basar

Datenschutzhinweise nach Art. 13 DSGVO

