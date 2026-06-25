Return-Path: <linux-aspeed+bounces-4307-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DFECDE002
	for <linux-aspeed@archiver.kernel.org>; Fri, 26 Jun 2026 00:06:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmbYn0RyMz2xn3;
	Fri, 26 Jun 2026 10:06:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::431" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782378633;
	cv=pass; b=c6/SzmC9oIXJFoWUJPM1aIO+K+HaSYIPNg1N07CLRLT1nmVWz54sVcYYUjjHQPTI4p8yGlOHTaumQ6RHqmzwi5y0wC7pZG2kGpVW1REULEtlw+N4yioztMgiFxrlZgJcG3v5r2UwuSR43wzbRpjjs4Jr0e75M41ObfkLluXfqgIODY/JsuTNaZEG1/Jb4wzUDoCtxGibwijbNi8e3CQeBMe2lLjJgD56c1MT91j5Ph7bAXXbc4tJkChAJT0SjOtzbYfmvDQEIxprMBHlG3J+xFF50zeh6YFe0mOif95aDEyJcrMpstBOE5MxtKCa/U7CAbNE/0FMgZ46A8Wyr3eKsg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782378633; c=relaxed/relaxed;
	bh=PybBbFFbv2qgp/wGc6XtY0wnuLp8C2DGakY4TdWZcjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPqDuybDoTFYLjTxZSEin83XktqqwNq3ZyN3DNlVWcB00ZbYwHm94E4/Pwlj+ktdDDNH5OIj3qSujlC1fR4nfbiWKlk1OgiipJnmuP3sXtmlKDuyVPGitlB5NxcDyHlJs06X3oQQqj4UvV4jbYm+W1PrPJAXJhvLgBwGKp14Bj8wolx+mlY1gXcxLwZfKN0afTSJwOowueXzBvom2Lfan9yqqZqpAr6/LonY9jN1d4iQW+oWlLn+Mg5AqgzmoxLdLAov6J/t9A3FvaKbHi9gk/vH8TakmD1kdnGGVt1J+WSnnb7Bnr5RvTibgH46nzpcJonyN2cH0ltvDNCw6kd4tg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=X1+QP61z; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=X1+QP61z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmCh73GVxz2xLm
	for <linux-aspeed@lists.ozlabs.org>; Thu, 25 Jun 2026 19:10:30 +1000 (AEST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-4631679f204so365197f8f.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 25 Jun 2026 02:10:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782378627; cv=none;
        d=google.com; s=arc-20260327;
        b=qBFwMNdm+fIPdEdGvDe1+uzFNt7dvdrq6I3QmrCq43ZQY9TCzD6D6nN4JDc5kxmZLN
         7B8dSXOuBuNtxlYJhWZV5MHhv77+R1TEebsHCU/e73Eeqxqati7RXFXJhszizIZw5Zto
         VExbS2D/UqwCT54j5k2eWhGJlsm/zAkKagRrA59Eue941pU6Pj6rJMd4W1HIxOL+5YxF
         LQigLsx0aUVLJo5iYQIw3Dx4lKlhbnd3Q9GfcG/qjnNl6APR787UU62FkVDLncUJsoG/
         GjqHRu07uHoPpLx46g4S3EHWmcuEYZWg8fceEnD7ssCBo66MMT8P/Jwr8Nl4uFaGr5fH
         Ze7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PybBbFFbv2qgp/wGc6XtY0wnuLp8C2DGakY4TdWZcjY=;
        fh=UF/ionXy2324qDKigi8JdLGPS7sYy2gL7HfIeeDbY9k=;
        b=cEaakdkwq+Yg1e6EGnNxtaAVN9O9LkLwfIIkoeT3zORRiAxI1TEtAi0seUkQA5845p
         Fqmn1xp3b+WxJ+tgl2XgJ/hivM5BEgwa8WWRbYB+Gdd7xq+HpWcYZ3RxU+6G+aXpApHG
         ySUF/wLwlsuNM4JbzlmgyPn9C9nKKFPou7zqrAqROuZ9SECQnf4hNxgloXzoOkCVJQ4u
         VoSNFQMoQ+rIv9LJdX+ZQqD4iXvQmCNyhD8VjldCCBKhiD0exdrnqbIaslyEl/Ck6OLw
         fqmXw4pYedUWV7I7jNQ7ssLLwyAFx3Kgus9eOLUIBDxa78w32ET1lrCqeJdQG8avEJRJ
         tbCg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1782378627; x=1782983427; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PybBbFFbv2qgp/wGc6XtY0wnuLp8C2DGakY4TdWZcjY=;
        b=X1+QP61zuA8BnmvW+nB5SgAVzpKsbYpF3gbwtQ6qV8HJAxy73K0naaTQSOvU8BOsMa
         QOsL5w+X8jp5NyFEFGmpH1e1TzTOePKUrV8XiWyJzyuy/LySKphrqSEGEsTvQqwqaFFU
         lm2CfrmyPU+nTXJeD2QVuwE7V9syht8aiN4916ggUaa5On+1+GyOjApRpxPRAypQrKoG
         MrLCwFgijzjnbqJw62bfALFroNVh+s1Ary1kFPz/7auFuMfLE3t+E3PUUAgPkS1XQDNY
         7YU3KxT9MVK/SDQ3jkEO6ss+GR512egbM/63QhukBkfZDZNSzTYLwyDUBh8unK2ddf91
         hFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782378627; x=1782983427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PybBbFFbv2qgp/wGc6XtY0wnuLp8C2DGakY4TdWZcjY=;
        b=I6AlmW4ruYkTDpqG7Fgq5w075RQqq/bTHASnKInviZsGRmrvUzPX55DbpQh98MkTxo
         m5bXwsgrQlW6glkGaloh7D3o2glPbvgvqB5AHkMVl5cx3kSwfJSXzdIBDd46RqPIfSXb
         f0o+wnGs/BiK/bHNyLktMiVCjAimdtC9sKQgVSwdGHF99UyeMfd1cemeGsQYuoZbcxbD
         8IcP3SzAbzPyHruc4pu8nyKSmr//HSFOTH7+xcwMXgezTuNOIq4YEeilTXH2qaDBjBrR
         OxpYa1r20QeZe3PAko3sfvp4CLDhCVer6ml1TF2766ivW3IjmnLf7T2leys1in6JBRyg
         +aUA==
X-Forwarded-Encrypted: i=1; AHgh+RqJxdT8NZ8eMToC18peOf56CZ5vdq8bOX9X77w3AKeqt3RZq4wT/MW9/ih9jqPs2dxCIETAaomGB06N9JU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yztb2k5WWsLnRxnLb6agrPnSHMScwFlUFWD1/NQCFycEz7HjtZ/
	y4aQacm1WsDSRoFZ4wEwp1rIBeKXMQ/F/Zj6USVQ4trAztCWZ5pUayi7B8pP0lAM6LyU22LJb6i
	2KGcLMOSoVwVFewlficfwLyOrBwdchhScXVXk6KMAmw==
X-Gm-Gg: AfdE7clrODx0ixUKglhZ+AkS/UPA0Y8waE9Us+C35+B+JLIuNGckGHlLY+wyZRmpzBx
	7/6qdetx0xir/xq6K7eNUr2H26VP/1JWOmbKSnmb4zveD+1yrUW4vup7qeG4bKczYy2z6N1kpA+
	74AavYl/fwvWo4Z398bsj1CsXi5jiFByb8j91Vmc4v/2pycb9rA3VKrj8RFhcLTyxC1tMx9jOw9
	XJbkOBUKiNA3QBNVSry7hS+ytJKe9J0tDOMQsGYQzVrHfwHmfWP89sgRRSg8lDS7btPi6IKTSJj
	YFwaHkloGTHAf/nRlexqm0t2/S0fbTIEuZmBLfQZOR55/X5c4GAwDIueQA==
X-Received: by 2002:a05:6000:24c6:b0:463:b7f2:cc7a with SMTP id
 ffacd0b85a97d-46da9508504mr2493751f8f.17.1782378626958; Thu, 25 Jun 2026
 02:10:26 -0700 (PDT)
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
References: <cover.1782224059.git.gregoire.layet@9elements.com>
 <73b2bd81ce70814612e6d3cb689c3296de742aaf.1782224059.git.gregoire.layet@9elements.com>
 <20260624-original-vigorous-mayfly-dfceac@quoll> <CAFi2wKbKr8FMcJeGWA5e1UZUTh2=LwYNkLEj6exd2as7=AcvVQ@mail.gmail.com>
 <b9ca9e36-a851-4a98-a739-ca99dd534d6d@kernel.org>
In-Reply-To: <b9ca9e36-a851-4a98-a739-ca99dd534d6d@kernel.org>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Thu, 25 Jun 2026 11:10:14 +0200
X-Gm-Features: AVVi8CdVW0AmRhEG0L6wUoqXHMzj3ec0waXKRN6u-RXjXnalVyhv5A88QhYFWcQ
Message-ID: <CAFi2wKY-73nXEKxp3vfB0RBsB+VB_stNk6NKk8gCopaoav6Tww@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: serial: 8250: aspeed: add
 aspeed,vuart-over-pci bool prop
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> > It's a Virtual UART. Internally, it's two FIFOs accessible via
> > 8250-compatible register sets on both ends.
>
> I do not know what is Virtual UART...

Yes the name of ASPEED is a bit weird, it means that it is not a real
UART. It is two 8250-compatible register sets, and the data path is
handled by two hardware FIFOs (one per direction).

> > There is 4 Virtuals UARTs on the LPC bus of the AST2600 and 2 of them
> > are bridged over the PCI bus.
> > So, from the host, you can access the 8250 register set on the PCI bus.
>
> You mean these appear (or are) as PCI devices?

Yes but not as a UART devices.
The two VUART are accessible under the same PCIe BMC device, at the
VUART addresses configured on the BMC. They are accessible on the BAR1
of the PCIe BMC device.
There is a 2 bit left shift between the addresses of the registers on
the BMC LPC bus and the addresses accessible over the PCI device.
0x3F8 on the BMC is accessible at BAR1 0xFE0 over the PCI device.

The PCIe BMC Device is one PCI device where you can access several
peripherals. It's not one PCI device per VUART.

For example, you can also enable the KCS channel 4 and it will be also
accessible via the BAR1 of the PCI BMC device. KCS is a protocol used
for IPMI.

Only these two peripherals can be accessed over the PCI BMC device and
they need to be enabled.
The host cannot access everything on the LPC bus of the BMC.

Best regards,
Gr=C3=A9goire

