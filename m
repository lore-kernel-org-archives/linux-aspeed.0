Return-Path: <linux-aspeed+bounces-3250-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690D0CEFD15
	for <linux-aspeed@archiver.kernel.org>; Tue,  6 Jan 2026 22:06:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dm4xg6GX9z2yFY;
	Wed, 07 Jan 2026 09:06:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.167.46
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767695499;
	cv=none; b=cVX0xbfJ0tb0uCCyQQi8pqMfPhnHSWrbLiAavsafxmvYFOv4Bigaena5BzuSjbnxnevDlOvUFCGrqINIcpMMCeIOTOab/149DYGot+cx75HInj5lp9utM58e+3jvQcURLlvlIfG+OLyXQII9CtKJ4j6u6Qxb6Cp0DV9bAHmVW+jw6lHM8CUE+X0gE+FtkrYrlaikb/LbLfdxDMlsW4/uL0EKpAmlFE1C6iUYVHPpW+HMIkBn2RPB3wNX9ElO4QvSMU70VN/9xzPc89ba9E9LKYGIboCU8lfg1fCz1LhlTiAWYg2KHlmx7NGYOoIE0cJ235ZNqXvz7+ezbQSDWbYCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767695499; c=relaxed/relaxed;
	bh=NsJJOzya3cvYihpIwq796R0nHpBIF37n18oyXT0fuvE=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=B9GcQfO+MnMayjFFMbzUT4VWrKoX/PjLBbFn6DlWesGElpN15XZABni7BNVK45gT+lmCZEQ7VqT03cjBd/Qs1h46AFoQ9gHFtBbSjkQAfankfvSiP74yafxQvanXttqmOp2DH2CxwxcJQ3dkKE02PwRaAS871iw6qrhs+FaJ3dVezqDp9d/Msh3cqcfms56pfm44jAPWZuV4q3m1f1aNdSrC2zWrogDVKdtSYSVacLZF/WFv46QpiUmpLfHwlvZ3Uo7I6HFMaXJ4GRjhUHFSqi20C9T1y9c7E/cARsp3jpa9pX53YfD9z679VvRk7s8oEuYgJMGLJiaoeAyGf6vVxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kdtNsG/r; dkim-atps=neutral; spf=pass (client-ip=209.85.167.46; helo=mail-lf1-f46.google.com; envelope-from=mike.rudenko@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kdtNsG/r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.167.46; helo=mail-lf1-f46.google.com; envelope-from=mike.rudenko@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dlnX91RMZz2xHt
	for <linux-aspeed@lists.ozlabs.org>; Tue, 06 Jan 2026 21:31:36 +1100 (AEDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59577c4c7c1so2827486e87.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 06 Jan 2026 02:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767695433; x=1768300233; darn=lists.ozlabs.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=NsJJOzya3cvYihpIwq796R0nHpBIF37n18oyXT0fuvE=;
        b=kdtNsG/rIBhlABS/6tS/VbaKh4g4Nxr7lnGjispjdLH/PnoQilGioGRff6ARvgJM+s
         IgJhdaX1IWfG2WB/0b5aWC25ouyw+LfH97oA0E9cbpH3wv6Iu4v6r9/Gz7vXn1wdYDtK
         YHZSaEufEoibfvODUZo5QSPVLPsTI0vz+bqNvkD6HVA7V860MzwyotS5TZaiv7wNC9OF
         DEK8mj1yrCebtmbwQ1/+B/+fDQlvGD+Rpsa/GoWaiREBSiNt5IS+shkVlYgahnxgE384
         AF5cmMKYZ1sgNXc4k1UJ7O1lYSSgGW+hZ9cXBG06/DYxxOLAu4zweW5mdbCTTyCbjdVW
         c4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767695433; x=1768300233;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NsJJOzya3cvYihpIwq796R0nHpBIF37n18oyXT0fuvE=;
        b=tVfTjpZosAis2hrIZCQ59pvPPQ+f1jCSiliagIFAP5xKLy6ABuhaQyMBER7nED7+WS
         yZWplj43ia69xFG1mA6tvJt9W4OAL7f3wbPqPZ1zZ90/TqPw92lcBHNalHVxL0fs5Lw/
         em+wkRyuwUk3WvIlQryP9UD/aLDlx2ptoS6J78M/N89jAj9ScARdjsqqJBZ2qEjcLk6O
         yprX/Qnyd3kZcYNyxoELSPNlxe40FjdDsWMHe4hnrj3YJLSTdvtCMbWwekO/Vlcbq1+h
         zbn45u6AkXFq1xFpJnrr2lVhcb+i6mcTPwLt1lGo6GRiM3ATzqz1UlB+iJxhFaJw+wfe
         QSdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1Khjwp8my61+T81qE1IwjVZIhofDqV4nh+/GOykIpU6srzAA3J3oCfyuuQACbOJIh5aaPl1optX2rtSc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxZxvHYymwGD2WVR5GN/RAii3q0qjW/CVYVB3dEf8USfO1cKDRt
	kn4RT1FZKYrfvW3pTHRnTxFZvb2Tr7o+B8wmb1Bz6DWOyRUK90NqrgoJ
X-Gm-Gg: AY/fxX5JlulfuWTBJRtNVx32p7wOOPPMdxJCjRb5BBFYap4eKBwbmu2SJIHRBEFBNDL
	QIqGNo+xKIVI4ilNvCdLZdCJYQLDWdob2Yj3R7EFf8kpqZuZ9Yz0fO2rH0OBD6fqnAQ2JGL5oFQ
	BleFFewsT4jqPZ59G7EeLJNYOBI0KgSAbdEhqDZggUG/vh0cjpEmYqDsNw49ZexVJ0iwDJFd5zC
	Ppl5C9dhA1atPpteqPKokA8Zspz3wu7yvEsNoyaZJuoeO88lmUu3rRpRMtgmLbGuFZOk6D7afuq
	BSwHxuvLofmUbHg/vdbgQIWg7klrMAb52pN3Wdw1wEcpASszGWMDd8OTvnJmnyizaVZzLUgzRfM
	TiNwglL3pcNRKbuhqsUQ5gnzCsDMzApog93PIwnXuxSOaNw1JZCUThVvyQLyQhwzNTeYPlp1/
X-Google-Smtp-Source: AGHT+IFmb+80wkKZdKxRHpidfReqxOHlUmLsipFT1rzzTuNx9rKmNHYR/9f9tfCpJuYk6MXE4I4WOw==
X-Received: by 2002:a05:651c:1148:b0:37b:9361:711d with SMTP id 38308e7fff4ca-382eae68ac5mr6985121fa.8.1767695432846;
        Tue, 06 Jan 2026 02:30:32 -0800 (PST)
Received: from razdolb ([77.220.204.220])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb8dadc0sm4315921fa.33.2026.01.06.02.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 02:30:32 -0800 (PST)
References: <20251216-upstream_pcie_rc-v7-0-4aeb0f53c4ce@aspeedtech.com>
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
 linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew
 Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: Re: [PATCH v7 0/7] Add ASPEED PCIe Root Complex support
Date: Tue, 06 Jan 2026 12:58:40 +0300
In-reply-to: <20251216-upstream_pcie_rc-v7-0-4aeb0f53c4ce@aspeedtech.com>
Message-ID: <875x9fuj7i.fsf@gmail.com>
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

On 2025-12-16 at 09:49 +08, Jacky Chou <jacky_chou@aspeedtech.com> wrote:

> This patch series adds support for the ASPEED PCIe Root Complex,
> including device tree bindings, pinctrl support, and the PCIe host controller
> driver. The patches introduce the necessary device tree nodes, pinmux groups,
> and driver implementation to enable PCIe functionality on ASPEED platforms.
> Currently, the ASPEED PCIe Root Complex only supports a single port.
>
> Summary of changes:
> - Add device tree binding documents for ASPEED PCIe PHY and PCIe RC
> - Update MAINTAINERS for new bindings and driver
> - Implement ASPEED PCIe PHY driver
> - Implement ASPEED PCIe Root Complex host controller driver
>
> This series has been tested on AST2600/AST2700 platforms and enables PCIe device
> enumeration and operation.

First of all, thank you for your efforts in getting this driver
upstreamed! I am trying to understand whether this driver supports
PCIe devices that have an I/O port BAR, where CPU access to I/O ports
is required for proper device operation.

If I understand correctly, this line in the Aspeed 2600 dtsi file
declares the I/O port range:

    ranges = <0x01000000 0x0 0x00018000 0x00018000 0x0 0x00008000

During system initialization, the pci_remap_iospace() function in
arch/arm/mm/ioremap.c maps the physical address range
0x00018000-0x00020000 to the virtual address PCI_IO_VIRT_BASE
(0xfee00000). After this mapping, inb() and outb() calls work by
converting I/O port addresses to virtual addresses starting at
PCI_IO_VIRT_BASE, then performing reads and writes to those virtual
addresses.

What I don't understand is this: according to the Aspeed 2600
datasheet, the address range 0x00000000-0x0fffffff (which contains
0x00018000-0x00020000) is mapped to Firmware SPI Memory. This would
mean that outb() operations get routed to memory-mapped SPI flash
instead of PCIe.

It seems like there's a missing piece to this puzzle. Could you help
clarify how this is supposed to work?

--
Kind regards,
Mikhail Rudenko

