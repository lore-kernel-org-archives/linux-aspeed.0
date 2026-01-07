Return-Path: <linux-aspeed+bounces-3253-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6A9D0D178
	for <linux-aspeed@archiver.kernel.org>; Wed,  7 Jan 2026 22:31:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmjS153whz2yKn;
	Thu, 08 Jan 2026 09:31:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.167.53
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767793612;
	cv=none; b=V8tfK4tDhYmS3RmOze70iMf+yLOD3uL8Jtj68jf0xdsOQ3ZwQZRk3rMuy4/NQGAYf2k61eWBrM8r95O6XQd9W494z09KgcpiivRyCNIQ9f7R84YQhH2QMs9gLLZV4+yWRZ0ZQ/cdjN4cWbKl4I3RgBsvA3hhWy++n0AY6PVFxjzL01Es3waK/vKnzrQMRF2ReeB+yQEBc3Ju26iva14HuUc4Bi6T2Gvz2/AN6d9jHTNDNuGOGAz70tn62R1ZS3q/bWYJ0db5Ko+IOF8cIz6iGkJlj5i2bV/t5iGcT21RBtFKF980x4oV417Fvrv/dosC54Tb6tv/A3ZUr66bn4YdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767793612; c=relaxed/relaxed;
	bh=zbg60yhotFqS4lYQ4SPbRRNfljX1PZuvfnI5dpwkZJ8=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Y+6AiTSTCjRM3PJieOs9y2ODKgiiYXVJceBAlWAb+OFqHnDLWhdESTMg1u72Qme4DZfyk/fVb/YTPECznK98oQ7BrECawWwT6Xm7gETIb0hoWwYusUOdXLfw7cdkIcX6S/maZn74XCTy5rOtZTpmURlLc7R5a9tl7o7vqD3PGatF5sNHAJxOcBj7sipjImp9eHUnlo/VtwSCrZxXVA4k1cp+i8OStPI6G06ZwCsCYoOJ17VFzA6X7YasMPkzpMXaxvYlQ5iqKvID1hRMADZttnYIwj6inSddLhAA4VBsgsSnMOLLCBa0IxY9N5sOhwNkPbj+7yj57RRYQD7S01kMcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mwgMciWt; dkim-atps=neutral; spf=pass (client-ip=209.85.167.53; helo=mail-lf1-f53.google.com; envelope-from=mike.rudenko@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mwgMciWt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.167.53; helo=mail-lf1-f53.google.com; envelope-from=mike.rudenko@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmTpy4vgVz2xbQ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 08 Jan 2026 00:46:49 +1100 (AEDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59b6f267721so782025e87.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 07 Jan 2026 05:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767793546; x=1768398346; darn=lists.ozlabs.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=zbg60yhotFqS4lYQ4SPbRRNfljX1PZuvfnI5dpwkZJ8=;
        b=mwgMciWtJ8+NhloOeGcFEmwqQZNhx97nfQTfpB5zqXZCVIjHXkeFcnXVwDbeZwaIbL
         dlJMBuXO/mOeonScbidqDR8g1kr6YqQHI3zt+RJAZsvQgLx5OqeF1hMu4drAibTe26ay
         TSuzIN/I2TwPWMnh0B4f5f9S7F/M3W/UYjYX/Nz0cXISCEsrEkCnUsXswuB7qDkCDJqX
         X7qzDcuKjDwIgM+fqe54cD8lwNjeRda0AyQreGXEafllJGCpjwe3e1xStMHPmPxa0Hpy
         22L70mJAhIYULLYcSD6jVmbcqKdP/6tGf4UI2EGObf4eiSl3wS2AmbgMB0xiaYfOkCpw
         WLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767793546; x=1768398346;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zbg60yhotFqS4lYQ4SPbRRNfljX1PZuvfnI5dpwkZJ8=;
        b=l0n7FgFYHLKr1yxqlhIJXZ2qKaT8uVO5Z2yyoE5MXA5d1YAl+/S8KFGuUCZmdcJHB1
         j6Wp6MfxCZA5N6Ogcy82ZVa8hOKSYZi42LqBLMC0+vATtE8WKwgd3AtpAKi0uY6MuLQZ
         rf++wYiXRJ3tjp3UL956Yl6FqZw/Wnto3YyvYQVPdx3oyjRmTccBBotd18VU/bmxr6M1
         Y87vR+57ZUOJ7okwruvKLZ1WoY7V4ytfWY0lP2nH3FwgEVr7cTOyTsnb1wJi7X73LptJ
         B7DFlFmqo8FFPNkTVY798Si8wQaaDeEoaWIhOBRKgAV3AkIr0/ckqL5z9VFGAIQcI0/J
         QY8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNGrO5SLRNS/qxdJXgHk25MB10J1k/jOUHhDDADkFUpr2xVLeG1JIqQIQzXUOZ4mQK0+pu7E9tnJ6tWFI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxAY2iDtP01Dp5wsq+iRTxolv2liBaHt2y7OynF0JnM8PQFPtOE
	H55LJWK1rfH+FnXNoxVl8CMLucx9BPSy+UmEQ39PoBUxWd0QVbOrlE5X
X-Gm-Gg: AY/fxX6qnR2dLOLjiJ7QgQ6crwWheyLoW1cn1wM8BXc7C6xAkOQJTim+P7r5whto7Op
	AAByynvk4VGcPq/KRxvv1HgsDkMxVi87YeMQJo+rs5bmg9vnBzmYgdiYLJJVv+89S3oNouhGjeq
	mFHCEo67Xa0CJzD5Q3rb9PnCKBLKUAIaXigOLkTVhSYfSA7NAF84rkIWrbbAyc9ziPheJNyrLNL
	h0lKf+pGxBilbwtRH2cG0zjguJUemYZEN9hUlF0mod9JjbC8KWZeyodx8HWH+fUXpxh/Ra82qUa
	yXSP/S45D9NCrL/x70TZyMOA43xZLfIjZl96nRwj20m8vCSJCgcKWrLoxWsVtikqfW9/FtVR8sV
	Jwnh0aVSY2LcwDYDn53tuuVre7OT94OB7nrZVJHaGlLj/Hb1AsWjtNnny28VXWlvfloORFj7S
X-Google-Smtp-Source: AGHT+IFBvFdbxlKvEOgpHQQ8YktwaenfQmmG9RkrtS+47ehkEyiqafqKukfyFwzDbyon83pp4CA81A==
X-Received: by 2002:a05:6512:2399:b0:59b:730d:4a57 with SMTP id 2adb3069b0e04-59b730d4b44mr510415e87.39.1767793545398;
        Wed, 07 Jan 2026 05:45:45 -0800 (PST)
Received: from razdolb ([77.220.204.220])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b669418b6sm1224545e87.20.2026.01.07.05.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 05:45:45 -0800 (PST)
References: <20251216-upstream_pcie_rc-v7-0-4aeb0f53c4ce@aspeedtech.com>
 <875x9fuj7i.fsf@gmail.com>
 <SEYPR06MB513404EB419B7850159F3CC29D84A@SEYPR06MB5134.apcprd06.prod.outlook.com>
User-agent: mu4e 1.10.9; emacs 30.2
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Andrew  Jeffery <andrew@codeconstruct.com.au>, Bjorn
 Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan
  Sadhasivam
 <mani@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
 "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v7 0/7] Add ASPEED PCIe Root Complex support
Date: Wed, 07 Jan 2026 16:40:09 +0300
In-reply-to: <SEYPR06MB513404EB419B7850159F3CC29D84A@SEYPR06MB5134.apcprd06.prod.outlook.com>
Message-ID: <875x9dcz9c.fsf@gmail.com>
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
Content-Type: text/plain


Hi Jacky,

On 2026-01-07 at 02:28 GMT, Jacky Chou <jacky_chou@aspeedtech.com> wrote:

> Hi Mikhail Rudenko,
>
>> First of all, thank you for your efforts in getting this driver upstreamed! I am
>> trying to understand whether this driver supports PCIe devices that have an I/O
>> port BAR, where CPU access to I/O ports is required for proper device
>> operation.
>>
>> If I understand correctly, this line in the Aspeed 2600 dtsi file declares the I/O
>> port range:
>>
>>     ranges = <0x01000000 0x0 0x00018000 0x00018000 0x0 0x00008000
>>
>> During system initialization, the pci_remap_iospace() function in
>> arch/arm/mm/ioremap.c maps the physical address range
>> 0x00018000-0x00020000 to the virtual address PCI_IO_VIRT_BASE
>> (0xfee00000). After this mapping, inb() and outb() calls work by converting I/O
>> port addresses to virtual addresses starting at PCI_IO_VIRT_BASE, then
>> performing reads and writes to those virtual addresses.
>>
>> What I don't understand is this: according to the Aspeed 2600 datasheet, the
>> address range 0x00000000-0x0fffffff (which contains
>> 0x00018000-0x00020000) is mapped to Firmware SPI Memory. This would
>> mean that outb() operations get routed to memory-mapped SPI flash instead of
>> PCIe.
>>
>> It seems like there's a missing piece to this puzzle. Could you help clarify how
>> this is supposed to work?
>>
>
> Thank you for pointing this out, and sorry for the confusion.
>
> You are correct that, as things stand, this does not make sense from a real hardware perspective.
>
> In fact, the I/O addressing support you noticed was something we experimented with internally
> only. There is no actual hardware design on AST2600 that supports PCIe I/O port addressing in
> this way. To enable those experiments, we modified our internal kernel accordingly, but this was
> never intended to represent real, supported hardware behavior.
>
> This is our mistake for leaving this description in the DTS, as it can indeed be misleading. We
> will remove this part to avoid further confusion.
>
> Thank you again for your careful review and for bringing this to our attention.

Thank you for prompt reply and for getting this clarified!

> Thanks,
> Jacky


--
Kind regards,
Mikhail

