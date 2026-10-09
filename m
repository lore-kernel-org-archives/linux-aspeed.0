Return-Path: <linux-aspeed+bounces-5163-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A934BCA5FED
	for <linux-aspeed@archiver.kernel.org>; Fri,  9 Oct 2026 08:58:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1LNs6V5bz30C6;
	Fri, 09 Oct 2026 19:58:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::633" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791536285;
	cv=pass; b=JqnYPDQSLEw43jZdd3Axz8gdssT4y+flUYAycLjYK1sc7u7SBRkjqrbNnj2qW03+iT4axHrVUu4+7yBqNsn+9p9A7V47RP2hSwjbaLzHm2LY4DvTqJf/g/QBwrQd7DNFqy+hzqPS096jjGASRHCiRMBw4bnIiT8RVxiE1acRCwsQZJyKJ0/C3vXyLLz4Ixo2iPUpc4mJqmlmq76iKBRoQL8s2oa441NvHCBSF0ZVGFobS0cK/wzrnK9VfzQhB9+Jy4u5JHwoUuo5KHWQUh8h+oTqN2HUztoJo0yhG2egSoI2BuG/zuB5I+7OQqeJTQeno/hnelmluc48r4jTyMM59A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791536285; c=relaxed/relaxed;
	bh=NfETxoF4ucCCZgxIexpfcNpfV4dYp0/llOpv6Ji+XEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDOKUx3SQX2KWA5Big+uEEggLLSS/PCqctR9zWPZU6LCDWVylAq1w0ug9oP92lwkyi/sqTk0EUWRKtigMRDWCcUhjyT/0hgDG9rXgeZLW17R0dW5sLnXQjjacX9vC23XTc43MsIJZm7FwyJ2DtknKjIhiZI+1gHABYKq9eEpAK0uDovyx1leiIMiNTmEPfYBOJP6ubU7X7/YKl2lWWz3a7VRYATI0CIcLXhs4I6JlJBgmYGtzWYtmbvRZFozPqFyxtkCQIMR3fW9A4PwRPLumPW2YzJ2Wx03TxkDT3TK0WhNYNIWNDyGrmmbQETm7JitSq7UPMmCfAyL1i3MGKxPhg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jpXTrW7x; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jpXTrW7x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1LNq5dSkz2y32
	for <linux-aspeed@lists.ozlabs.org>; Fri, 09 Oct 2026 19:58:02 +1100 (AEDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-c29c6a3930bso815153066b.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 09 Oct 2026 01:58:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791536277; cv=none;
        d=google.com; s=arc-20260327;
        b=JcqZ8TtWS6XDx0f/50BsLcmJXqbNOcgFClcf9kNB2iuZu4hE6RBKtZ6S31U2561uVN
         x8Qg4890w5xpKGx9xOq7Vf/eDJ3vvQ30r91n06wE6Cg46IRbhDUb/9wrCkjQ4/zNK+L2
         XMERU/QAqSESWeZRhOD9CGW0oOfuBIVZKDWkDSflTGNlygT2KXP2eaURo6ycN+WPboft
         3e/Im8kWPdQE1mkicXUk94sFePZ0Y29WglzWButxTCUsZr8gZRoBg7YX0WegmQB4LiaK
         ZYE5eKUZGn65QRrQcFubN7WhXQe0+Uh6h+YMYZlXpEANgJyHtGSFmLKGE8/CgjnzNE5L
         H/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NfETxoF4ucCCZgxIexpfcNpfV4dYp0/llOpv6Ji+XEg=;
        fh=CsK87vSCvoLXmJZvyS7PRi5tnwKxERHhLHcuRuYXdaw=;
        b=Ul4NS6H3BaVEck3FOyzF9IUSWiDGenZb4xlGiE1rck4ic/U0fHmW/sRTRnv9Z1x30/
         jXhRwyIwU6VyqUPVYUlOC6HdR7i9gfcSTnJDwoXttnxBgrxbFT/19CV89HX6pQFO5LlC
         m2A3orvn1ie63pObKxE+HHyNFxdWT1IVZherFBj0HgfMtMP5cqw3EX7mbWS9JnH62MMF
         4Dz79DwBPjM7zGoueINe9R1A4MksVFt/LiiocagkOh83zDxLfNGEWBs8r8kn0SG2aHAA
         jjRoCKPJhj/UTzwBh6rGJ2hnfmAKHZHQ+/MnM55A1/v71B5Eju+WYIQu9tWhlYmgs7DW
         wWQg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791536277; x=1792141077; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NfETxoF4ucCCZgxIexpfcNpfV4dYp0/llOpv6Ji+XEg=;
        b=jpXTrW7xe4C+9KcRZ0f48EdZocPlmrZXEKfZwKL711x9t57V5O7DbwE0bP7OwE7ZOj
         MMOiUyUmrymeTEjdikItRNFzzYqMB/zq+tQBvlaLbJlGbtqaq9dLpjyqvor8iFfqdYu1
         HhLFMYwGkloMK03jtFm0gpGIlso871wm6udINElTPQNdCaYlFZTghugTQXnY/TZfajuu
         TGpBqabEYZnIcxCKZ5L1hMMsiI+f11RfTSwcWcsM+qByewGCRO54gvMqN2dcT9GBotLh
         TpR3WvNSmFDkOaoBXGlYktq5t7BI5Ru+f30HiAg3Aob6+WM0vOLn2EXIiFtNTmn8dzfT
         63+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791536277; x=1792141077;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NfETxoF4ucCCZgxIexpfcNpfV4dYp0/llOpv6Ji+XEg=;
        b=A7tQBBAQ3Y3XVoO+0qKBipWoCXKsLT9tdepIVGLt4lskn3q1EQMlqjZbAQHvcIh84Z
         vT31eE4rNx/1RTbgrttmeRQwgixtgRB6R3r+okWZw7mQcmqoLlxn0RaztYeLhXuaQapL
         APZQZF0Wm2oV88BF3BR2GU8AJ8qmuJUvDI/n7yNaU3EY7nYNYSL59D4YpnK0+JzBVm1w
         W7dU3UnZO4B55Ux1/iamQ1Aa9qDmR+xvgL+BXZPUH8jDFNAJxAUlqVKqBI8YWUY6mwX6
         +RrBk4dBbIM0F6lAIOVQqUJds4xP3+EPoruAXq9CQgyqpKRt0eWdRzbPX1ME2SanDtm5
         AHkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxper6tEzh45G6Adew5D9k6hlXH739Aq6ndKy2qJmj/hEICWSbZF4ASRvBUsFeAF9Ww8WN3dOxF43L+bQs=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIVF5Q2CbA6uqZbhll2lHyJcBioR3n85qxiWISXHQL0+zERdDVI
	AAG4lF9vlYCyMnORO7oIA9vC6A0wXmT9KzpxbEtdGe5Z6lx36Tj2DCS/C7xl9pCcgjVZtaooLGi
	aUrSTslc/0vwlCZ6fkTdT8grwIm/UjAQ=
X-Gm-Gg: AYBFou3sHFA3Vmx6WzJlBnnMXpwCUFbLYOwqhEDiMQiiF1ayM1oGLrUW1jGLz6axP64
	GeRy2L5wqJ3ETDruOlMooAJSeDGA0htd06VFL2FAIvsdtyRxcs68G9RkuWZ5z9pd51cEvOla5xI
	2hJxQeqmvFkC876oiGstOQtfhV0NpV0qtCtc0VlxYzmsYbwjzu4Cu3MX9Umtcjw+v+WzXLmnc0V
	axq9h6jOlMMixYVEDXAN4tRpPDUPU3NOHIovHvVY4j90OwHhPErbPOgoB/19UcxU0BMvTiTWGqI
	X8vB+qeFODsMw/Ddhr0c5hvgZ8TcLkpfriEZ6f34lbKLv7dr3ZlJsPPyYynnoGLJQD0KjEp5BX+
	gwfh4NrJqwg4/WUX2Et35lCFbkYptPf1E1H7HtRXJ3O6CQyE+t9MNnCDU1PVuBD4lP3RI+JyCP/
	QRYg3e5woc2CgrK2Im4Vz6jyCWuWxMx/5pm+iBr+Qc
X-Received: by 2002:a17:907:c19:b0:c26:19de:9ae1 with SMTP id
 a640c23a62f3a-c31a9f92fafmr107811566b.32.1791536277123; Fri, 09 Oct 2026
 01:57:57 -0700 (PDT)
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
References: <20261008-aspeed-vuart-v1-1-d2be17c99cd7@phil.gs>
In-Reply-To: <20261008-aspeed-vuart-v1-1-d2be17c99cd7@phil.gs>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Oct 2026 11:57:20 +0300
X-Gm-Features: AclHuK9b12DMuE5IdZa06_5PZbK1OQ4johR6fh1kbHOWemGxMcH63xDoKEpiMps
Message-ID: <CAHp75VdiO9tPX2vLqsX2-omNvs-YjkWWD-HOiqyDSzpJrrZ_5w@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_pci: Add support for ASPEED BMC VUARTs over PCIe
To: phil@phil.gs
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Corey Minyard <corey@minyard.net>, openipmi-developer@lists.sourceforge.net, 
	Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	linux-aspeed@lists.ozlabs.org, Ninad Palsule <ninad@linux.ibm.com>, 
	Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 4:27=E2=80=AFPM Phil Rosenthal via B4 Relay
<devnull+phil.phil.gs@kernel.org> wrote:
>
> From: Phil Rosenthal <phil@phil.gs>
>
> On systems with an ASPEED BMC, the IPMI Serial over LAN (SOL) console
> shows the firmware and the boot loader but goes silent once Linux
> starts. The UART that the BMC bridges to SOL is not a legacy COM port:
> it sits behind a PCIe function that no driver claims.
>
> ASPEED BMCs such as the AST2600 present this "BMC device" function to
> the host (1a03:2402, class 0c0701). Besides KCS, the BMC firmware can
> expose up to two 16550-compatible virtual UARTs through it, and host
> firmware redirects its console to them, for example "IPMI Card SOL/COM2
> (Pci Bus9,Dev1,Func0,Port0)" in the AMI setup of the ASUS Pro WS
> W680-ACE IPMI. Register these UARTs so that the kernel console and a
> getty can be used over SOL.
>
> The UART registers are in BAR1 at the VUART's LPC I/O address shifted
> left by two, one 32-bit register per 4 bytes: VUART0 at 0xfe0
> (0x3f8 << 2) and VUART1 at 0xbe0 (0x2f8 << 2). A VUART that the BMC has
> not enabled reads back as all ones; skip it so that the ports present
> are numbered contiguously. If the BMC exposes no VUART at all, decline
> the device so that it stays available to other drivers such as ipmi_si,
> whose PCI table matches the same class code.
>
> The function has no INTx pin and advertises 32 MSI vectors. On the ASUS
> board (BMC firmware 1.3.13) no interrupt was delivered on MSI vector 16,
> which is the vector ASPEED's own host driver uses for VUART0: transmit
> stalled and nothing was received. Poll the ports instead.
>
> The same function also exposes the BMC's KCS interface in BAR1.
> 8250_pci does not request the BAR, so an ipmi_si interface described by
> firmware (ACPI or SMBIOS) can still use those registers. ipmi_si's PCI
> driver, which matches the function by class code, can no longer bind it
> while a VUART is enabled.
>
> Tested on an ASUS Pro WS W680-ACE IPMI (BMC firmware 1.3.13): the kernel
> console and a getty run on ttyS5 over IPMI SOL, while a non-PCI ipmi_si
> interface uses the KCS registers in the same BAR.
>
> The register layout and MSI vector assignment follow the host driver
> from ASPEED's SDK as posted in 2023, which was not merged.

There is already a driver for this 8250_aspeed_vuart.c. Please, do not
add new quirks to 8250_pci.c.

--=20
With Best Regards,
Andy Shevchenko

