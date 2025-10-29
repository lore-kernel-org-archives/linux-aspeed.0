Return-Path: <linux-aspeed+bounces-2684-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EE3CCF9E9
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Oct 2025 09:58:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxN4F1VKfz3bfF;
	Wed, 29 Oct 2025 20:58:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761731933;
	cv=none; b=XmQPCjUON+rn78al0s14TsxoPQFgYp4aYKAxuCrzrlIobgpdp3MnZ85cFahYCidz82M+o/o3kin1f9wbwsGJ2o19X+YaEkG/KctRE/4hHvOX1b/jeN/ufC8CLPTqLoCgeb5Bjg08ndUVOLDDna95IdGTRnZoYYCtKE2k4LwOlDMCoaW4C5kkuAUq+0plaruGR8s6YUCKtiAsQqzficJ2Gl3dgakwLARZUHHHw7QFthcEYu9VelFLBBbAK8CnU67xIYKsHqwC1PWqJeSxZtxY2gdl1e7eqoY4HPlYXTrvxwfJQP2z9d3QItx4j97uv9dYyv72mp3sd2L63aCEWV0F5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761731933; c=relaxed/relaxed;
	bh=tdMmTEVXmrdUQVal1cKnxdF6jTyKX4No0foVL6qsIc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QA1bQjcIhpJ6GpUAKbeb6lnfvz5DheuwyaVWb+yllIMiOtJkksy70DkzkHJIVVaP5w1+UoNlNccVFxck8Oi3mwHXlbnJSQ+udK+lT5oNij9tMMZ0mQi5WAbG9YnyhyDpNT3ZWBDm2n0eUtc5X17CloAGZBpGjiGPrka5fP31E8Q5q9y4nFNk9lpKyc3tF9iJhMHmN1XWNmWK5PrLhD79oupO/3yLKrWa7Strh/p7/Opf/qVdwOkeiUmat4wXhFzF7vBdESIo3w5vLGJSJYLpDP4D/nuFN46Yl8FUWOJI758TKQnrdiFI5PVIlkwECSs2kutox1QrYkx8RE91juuoLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.160.172; helo=mail-qt1-f172.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.160.172; helo=mail-qt1-f172.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxN4D18DFz30hP
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 20:58:51 +1100 (AEDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4eceef055fbso72274401cf.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 02:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731928; x=1762336728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdMmTEVXmrdUQVal1cKnxdF6jTyKX4No0foVL6qsIc0=;
        b=r30LtXFL8kFSF75V/+cLjUuEW2w5dMlF+FV8OhWe0pGpuHeg9HoCV+FtAuFX0p0gNM
         vTgnE7G8GI0FRMOSsVk307BlRbOVKifzANfVjV4TcCw6paaNOsuuiKqpFBLmuXeXryS1
         S+v+G1l6wtCBl2MroRY7/h6fUM2YiP76IYaNYtbOcEIdCUn5Kkd3Qa+4UxJxrSq8jKg5
         PvHI5WCzdKOqmiuBEDzouy+q5nl1nBCHQNacOBfdHojgu9ThqlTS6ttfEks4nwjEAf46
         EiA2XnDfYpnHMZkftofpRVSvfdnxW24kTgDqA6YkpIeZgcs4Hvq5YO3H6IA0DjKC24a3
         sfOw==
X-Forwarded-Encrypted: i=1; AJvYcCX7Mt3m/rlK/jw3oCSBYXeHLLETLX/JjJzBvBPkZuLeFM13USTk1fv7GeeW2GYUVK6xJF7Cd5URopLV5ps=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx99Sp0PHkFUmLne1+xAzLKc+tObnMYmQ6M7Ku5GPyu4NdlCo/W
	Wa9l3dmQlRGFxWD2ai8XD08uFbCn3xNaudU6YduBjnHlhAiq66OaL9DQdHpZ8ym/
X-Gm-Gg: ASbGncueP3yBmRd85ueJIf3XE8jkjcgCJv5zPvmM97V/vBFVyq2RbY4HJlUUEGq3Cj5
	YfY7SijLFLZS62OGrqee5/c5qLvQvycmzPyJNLaRzMnkRR1maHdacvzlvmEvnKabZwuMBn71HFv
	jrGukXCxuRW98PI0hw9cl8Y1aAcKp7FpjWFjlTv7l4ng8zzDAr8IySUO1MGraSJ+Ml+KWIJRUst
	mRNsOlRFkEUcY1PV/3NGggdn65B9HV8czWu1aMRYunz2WZZ+/xhjTi+NdBeN7PzY8SQsGnOo4Sg
	x5ksUG7axZ/bWtYXqMtC6c3yKBIIF1xkGktCtBNRcz33j3mFyI5+PWRjYoK+tjB8TrKwBx6d7mH
	8laivndyNHmxZGUhRLuGas0TU45+j4m6zfv0UH7umKWbXivo7AUFnj53ixPd7HzbpLz2jCIa9iS
	GVEUMPJgM2v+mEhpSSRG8jHvyLl+dxX+z2LxITABfXyA==
X-Google-Smtp-Source: AGHT+IGJfiXkJPJ2q31IKqO1qWk7oZeyQMGPhNgwuVP8fSomhNdCkEXXIaHJTvvFHZumRUFa4OIt6Q==
X-Received: by 2002:ac8:7dc9:0:b0:4e7:2b6a:643a with SMTP id d75a77b69052e-4ed15b336e1mr31375481cf.12.1761731927861;
        Wed, 29 Oct 2025 02:58:47 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba3860692sm90164261cf.30.2025.10.29.02.58.47
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:58:47 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4eb9fa69fb8so59350691cf.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Oct 2025 02:58:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8Dh6rlsJeZxnn00DW060eaPrvxigQds5X63YaW0eIzotQt0nccFWH18Dkbaj+D2+D7XEb44E0ARXaB6c=@lists.ozlabs.org
X-Received: by 2002:a05:6102:d87:b0:5d5:f6ae:390a with SMTP id
 ada2fe7eead31-5db906e1ea2mr632557137.40.1761731454123; Wed, 29 Oct 2025
 02:50:54 -0700 (PDT)
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
 <01573262-69a8-44cf-ae02-2e9842c59dde@lunn.ch> <TY2PPF5CB9A1BE665D988A413B8BCD5CA27F2FAA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <7c0c966b-c45f-47ad-9243-b945036a9bd2@app.fastmail.com>
In-Reply-To: <7c0c966b-c45f-47ad-9243-b945036a9bd2@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 10:50:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVueyxmATwS_EnqBBPtX-O0bw6Ubnj-Dey8wN=pEvo_zA@mail.gmail.com>
X-Gm-Features: AWmQ_blS6idckwhpIjkOWHP0NGDWxrc7vZpSwkjlsFZQOSpuaInPPIOtTjyVPpU
Message-ID: <CAMuHMdVueyxmATwS_EnqBBPtX-O0bw6Ubnj-Dey8wN=pEvo_zA@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device tree
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Andrew Lunn <andrew@lunn.ch>, 
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

Hi Arnd,

On Wed, 29 Oct 2025 at 08:26, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Oct 29, 2025, at 03:31, Ryan Chen wrote:
> >> Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device
> >> tree
> >>
> >> On Mon, Oct 27, 2025 at 02:42:01AM +0000, Ryan Chen wrote:
> >> > > Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700
> >> > > SoC device tree
> >> > >
> >> > > > SoC0, referred to as the CPU die, contains a dual-core Cortex-A35
> >> > > > cluster and two Cortex-M4 cores, along with its own clock/reset
> >> > > > domains and high-speed peripheral set.
> >> > >
> >> > > > SoC1, referred to as the I/O die, contains the Boot MCU and its
> >> > > > own clock/reset domains and low-speed peripheral set, and is
> >> > > > responsible for system boot and control functions.
> >> > >
> >> > > So is the same .dtsi file shared by both systems?
> >> >
> >> > This .dtsi represents the Cortex-A35 view only and is not shared with
> >> > the Cortex-M4 or the Boot MCU side, since they are separate 32-bit and
> >> > 64-bit systems running independent firmware.
> >>
> >> DT describes the hardware. The .dtsi file could be shared, you just need
> >> different status = <>; lines in the dtb blob.
> >
> > Could you please share an example of a .dtsi that is shared between
> > different CPU architectures?
>
> I can think of three that are shared between arm and riscv, with both
> able to boot Linux using a variation of the same device tree, with
> the .dtsi file being included from the respective other side:
>
> arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> arch/arm/boot/dts/allwinner/sun8i-t113s.dtsi
> arch/arm64/boot/dts/sophgo/sg2000.dtsi
>
> All of these however use the same basic physical address layout
> as seen from the two CPUs, with only the set of on-chip devices
> being slightly different, such as using the native irqchip
> instance per CPU.

I can't speak for the last two ones, but the first one is not what Ryan
is looking for, as r9a07g043 has either an ARM (r9a07g043u) or a
RISC-V (r9a07g043f) CPU core, not both.

> In the AST2700 design, even though we have both Cortex-A35 (64-bit)
> > and Cortex-M4 (32-bit) cores, each runs in a distinct address space
> > and sees a different memory map.
>
> This is similar to the Cortex-M4 on i.MX7D. This is supported by
> the Linux code, but I don't see the corresponding dts file for it now,
> it may have never been merged.

The keyword here is "System DT", where you have a single file describing
the whole SoC. From this, separate DTS files are generated that
describe the view for the application CPU core, real-time CPU core,
control CPU core, etc...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

