Return-Path: <linux-aspeed+bounces-2634-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE235CCF9E5
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Oct 2025 12:54:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwD3L3Tq3z3btd;
	Mon, 27 Oct 2025 23:54:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761569646;
	cv=none; b=N6hYrZ940Y23IUg56QWuoQ0UIJ/y7xnQGvY02l+el0BOfbczWe1ETXLb1rXTb6RHN/+VCxeeanbiYYtxkA8sVOxto3dMjfuLcNNUvWvoLIXvNz23cy2ZsMuu9/JtAWV6D0FYM9l8TYJxJcXVekZyCNvaEFstN5NmtUz/kqxYiP+8ylQEa2pjVVYwoJ813fm2CPqMyy/aG+77o2M27ITI4XfdlMe/k8Zv4CdlwoziULB8+1u/5hreMK6/VwlYMEvpgE+e3nw/au5I89DcnkhxZDJ1QmNvoE7fHFfC43HkgvJNZkAropoeeZPfy3rdiASYS9jJYZbPLSyj9OJpoB7aFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761569646; c=relaxed/relaxed;
	bh=yOYdLIvACytBpVHjrdATGnV0/c7ZzUCpXjvbRDnZ37c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YF+tz73kuK8FNYbj5BCbAjuEjdmK7JBmz4EIdNER1H9Hi+eYBIIKUaR5YA/T6AeK2yaQY5qHONCP22AEjdlkTlW/GfL1RBiHnAkEk9SSIXpohS6WE0/aojQTUz/TSL27vaGHsAV2+I9ZGR4fgQvs9kTk0E+jXlsaiuebnREnQiKcNjPvxmmooIwo8sao8EhgKwuXcqagqW1uqqNWCBwJE/6gTxtZEcooqs2FzTBt1ybBNYFT3XLbTwEhVbNQHTR7Zt9kt4WR2Y8essWNhBFONhgEkskIiSxCaHPrVECV3/SNW2y7FKh52kgWCN0/jsfuoqA2PVMktan4jqM5PB28HA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.217.53; helo=mail-vs1-f53.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.217.53; helo=mail-vs1-f53.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwD3J1JVhz2ytT
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Oct 2025 23:54:03 +1100 (AEDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5db3cb378c3so1607588137.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Oct 2025 05:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761569639; x=1762174439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yOYdLIvACytBpVHjrdATGnV0/c7ZzUCpXjvbRDnZ37c=;
        b=s02dndB7Sr+9TiydWFQ6bHjSJGTHiQJnERrovpJ/XuRYUbPDrMo7F902hE/ePkxE2J
         1Tg7HqLl4JRlR3CqSNTZJbxgFfHIc5G2x7NspLppYTrxwf0A+tba/Z7mi/THI1dbw71x
         ixtR996dOMkFXBd7av7gu8OkiTbF3hN8kCxbYhTSr3bpM+skviF0V3sIzjJzjzETSvmc
         LdG+vsh+BPVWZhNqoQlcHtJ7RyaxO7SJNXGAa27KmbcYX55sW0uwf2VGeKi/Q83PStfc
         s26jw1t4kB1+Ez4MugC1bH5x2Tvk6izYy7ez0NMtTQNqoK0C7yn877gYJ79eyohZ8IoK
         Cjsg==
X-Forwarded-Encrypted: i=1; AJvYcCUxvtomdI/lViM0OFFKhK3Puv76ZHVsuGmlGTncCQwZEPitI5QPNAfrEpbk8A6AB3+9bjZfBS/nkb/8jJ0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwOcyabZjo8Caj8O/sMLFaW8wZ2w+B73RRu1WnmGA/4A1la+njn
	+Km102RNynERx8MNfHYbRaBSJ4P+fqgwpqc+uPU3RXIYlXLfmrkBKuc+HAIJKMcT
X-Gm-Gg: ASbGnctBjmoBn+kK6EI1hpxSIFpCnoSAEQnVPUDb+QaIkqZPmm2yoD82w1OgE5rR00K
	0ss7p6vJW/D+roEKYM9IhFsf+1zDhTf9qpNiFarCxjkcT1VGF2c35YPkDAODA0/CVE1nxtUepWk
	WgsVe6uRP2QQiBFPPYKpcMPsX5rE42o1Uea5YDjX24GSTpFZE/tvnyL1rDGLpHkBsxGpmbP5a8y
	HkNycnIFrFBLnChVACTylD7eUnp/XGtxxgnNoa7iHJP30ND3nJnuVOHmU+uUnaKG1jBQfXtkHhc
	XKs6LJKrDP91UpdJrnTrA96f67oVW1nG2EMVWYGqkl5L1LOW6MaOhdIsBnofy/ly99NDPzHItZ0
	apbscKNkScC+zqKiYWrNTcRXJDtwV+1nvq/AiFIW7JsevKNJLJH6gK4gVlJOu0AVZc2A62DysGB
	XCUKf3/W/v71g9lHZgFqVtWainaGXW4nieEQjwTcdkrrR0ngb2
X-Google-Smtp-Source: AGHT+IGzOZ3EFOqu+CSLSCph2htYhcRQYT9pXLY34ZY3YfizB1jZ1eDf7T61dR1hgXm8myTjug6dcg==
X-Received: by 2002:a05:6102:949:b0:528:d2ad:1f54 with SMTP id ada2fe7eead31-5d7dd56b320mr9586423137.8.1761569637857;
        Mon, 27 Oct 2025 05:53:57 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5db4e521906sm2631789137.8.2025.10.27.05.53.56
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 05:53:57 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-932bf9df69dso1439929241.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Oct 2025 05:53:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyuRxJDyDemP5fN7UO018gpeuX1UJVIt+l4FdnYmzVWc2ri0c69brNzObe6DEUys5NX0iWKSwHa1QUGkY=@lists.ozlabs.org
X-Received: by 2002:a05:6102:26d4:b0:522:86ea:42c with SMTP id
 ada2fe7eead31-5d7dd5a64c5mr10674902137.11.1761569636629; Mon, 27 Oct 2025
 05:53:56 -0700 (PDT)
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
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com> <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com> <TY2PPF5CB9A1BE6CF8336D211641A18E2DEF2F1A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <71df9bdf-53b2-45e2-a9e3-5b00a556f957@lunn.ch> <TY2PPF5CB9A1BE6F3E95C7FD61CF4F90ECAF2FEA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <fdbc471f-514e-4521-b7a1-dcf6127d64ff@lunn.ch> <TY2PPF5CB9A1BE6DD93D0F397C961D5CB5AF2FCA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <01573262-69a8-44cf-ae02-2e9842c59dde@lunn.ch>
In-Reply-To: <01573262-69a8-44cf-ae02-2e9842c59dde@lunn.ch>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Oct 2025 13:53:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXAOPemhTjdJqminXhi+1+Dsc5rN1GLqAUcfF3ZyphRoQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnc0FKdJRTj1IhXsyeFKk3WmW431oeoaAfsizI36RwwOH6YiF14-6GD61A
Message-ID: <CAMuHMdXAOPemhTjdJqminXhi+1+Dsc5rN1GLqAUcfF3ZyphRoQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device tree
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Arnd Bergmann <arnd@arndb.de>, 
	BMC-SW <BMC-SW@aspeedtech.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Lee Jones <lee@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Nishanth Menon <nm@ti.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Taniya Das <quic_tdas@quicinc.com>, 
	"Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

On Mon, 27 Oct 2025 at 13:01, Andrew Lunn <andrew@lunn.ch> wrote:
> On Mon, Oct 27, 2025 at 02:42:01AM +0000, Ryan Chen wrote:
> > > Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device
> > > tree
> > >
> > > > SoC0, referred to as the CPU die, contains a dual-core Cortex-A35
> > > > cluster and two Cortex-M4 cores, along with its own clock/reset
> > > > domains and high-speed peripheral set.
> > >
> > > > SoC1, referred to as the I/O die, contains the Boot MCU and its own
> > > > clock/reset domains and low-speed peripheral set, and is responsible
> > > > for system boot and control functions.
> > >
> > > So is the same .dtsi file shared by both systems?
> >
> > This .dtsi represents the Cortex-A35 view only and is not shared
> > with the Cortex-M4 or the Boot MCU side, since they are separate
> > 32-bit and 64-bit systems running independent firmware.
>
> DT describes the hardware. The .dtsi file could be shared, you just
> need different status = <>; lines in the dtb blob.
>
> > > How do you partition devices
> > > so each CPU cluster knows it has exclusive access to which peripherals?
> >
> > Before the system is fully brought up, Boot MCU configure hardware
> > controllers handle the resource partitioning to ensure exclusive access.
>
> Are you saying it modifies the .dtb blob and changes some status =
> "okay"; to "disabled";?

"reserved" is the appropriate status value for that.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

