Return-Path: <linux-aspeed+bounces-4889-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381B6C624CE
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Sep 2026 00:04:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYmM06stWz2yD3;
	Tue, 01 Sep 2026 10:04:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::535" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788180632;
	cv=pass; b=PUtVpb8KReyS1rXL6TPflgfkEtWNZ37X0A0oc91yUlDH/PV05aWudHRqJ4gV5M6tL9raoekObcpZjGq+BqtiS39vqCMBoy8yng2oj7OKZxMP4x59+1l5/43pmKCO4OJ/q8f4tXVb4fgN4MbUPAQISzBdEPQOckTkAYWfwe8ZK7EVYp4gAErlDa2zkNI5PIepJGS/UYV11lwF5/hYodG1QuqyN9khXYbD9GXbBD0CQpR8/2g2kP7JhoplPXPgWP8CwtwANkrhBc4YbgaHxYCv/mpZ3Ca8BsTk04hUaLPy501FTHUAt9rmR3ChnbKn6Z53khUaHOdEemcxqiaTP4YpjQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788180632; c=relaxed/relaxed;
	bh=xQtOWDkW+w7ybqaZBfV9HKOca4eSda4cgJxTQC5fkhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fl4tpvgz0CyubtFFT4CavEJYtr2BNLmSIT8wAqOM7Lqie8+3OC2kZWpjLSL5duxK9X1agrlu5vwwyv8F05urPPH3Amo1CmNr4OrDOdPVHwubGifxQ148V+xO5PRRkaO+u81rqok8PEo8tt2amoHrDzht7d+ayu6zDB8eIOGiCAdDTS2pz7ONevXXwbYfDp4oUKaWwush0XY0WCd+IF1oA6XzZkX3+3TBzIy1TPNJjkxZasRdMKsa2f9xdIP/0vvUYfHWh/WbidupI4Cw7ShUJvv9MgSrYunHus6w2AG9QD7Ft9iKI8oJ6LXMHOBWrqcESe1RYQGRYwHAe4UTnJ73Eg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IBel7LHb; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IBel7LHb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYTP26xjLz2xLf
	for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Aug 2026 22:50:30 +1000 (AEST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so5506905a12.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Aug 2026 05:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788180627; cv=none;
        d=google.com; s=arc-20260327;
        b=pk4GJtM3Df0yXwFXFZ+gL4neM024CveI5EvlygFsol7G0ot8x+yUT+1m+2sOIZfBLB
         jtfidkc2SZOavtDYL41WaJbhb4bG5o55zIwZCwzsRbT0z6Ee+UboqRw+AH4P8tFj7GG+
         G/MXRY9uLyfenyJNuPiNW11yFuxN2/H6Psnl1VYeAF67igxdNZ2N/Kmex4nGj6kzsxwD
         ZeUu1VIjIsWOQIqIAMJwyRga/6dko5ml1aWgaxI/2sxkbw0asG/3kxXOnUP3AuW/6m9P
         OY1R/hMdoA/IaALZ0xyP6jKTE4cYHmd02JS3RtIjaE7mhj1tDtvDFB6OJnoUL380OYFO
         ALpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xQtOWDkW+w7ybqaZBfV9HKOca4eSda4cgJxTQC5fkhA=;
        fh=nMuiD93XANa2gGtB3NvnJSInNAHTUaSXtJbHyrZcUvg=;
        b=s30qI1xZsmuJ8f1NbZm91HSDdpMmXLFwKCX0bdvgUAwnmEqkYiowUbTYBYRHbnyZdD
         CsPyRBdm9U+CLsyr1P4Ln0zt8dGWgdhe6iGj83HyEL22gmZVEFh0Ma6mzn41qDkMCrAJ
         tdIoUFhBFNsxChV8+5K/Z+937P6fzN/oKK7ruM7eqvd40k223duyCGv6NI+aHJaGKxke
         BQWQpIDYHG/P2hQbuEXWDSBsBlOOGNJaTibuiPWo4i4UlmKKR0ZUrRgfT9Rd1LY+FEYt
         zzta/Zlz0kp2cDT6KibUH5dPd91XNYW3BZyqjJ5z2Bic++itjhwi59SvfPNljcGHxiCL
         M9Sg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788180627; x=1788785427; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xQtOWDkW+w7ybqaZBfV9HKOca4eSda4cgJxTQC5fkhA=;
        b=IBel7LHbTa7dFt/Gb88jRSnxt4Q8bIEPVP9R8aaOS9rcokRANeab1QYePSmC3WMHUT
         ntDajifSBdnRU7rfe3buotKw5QmXduo8zFEaCD4VCXjiRlJqPbZrDEjoEVy6Lkx6dcBW
         U4ihun7pxK51mothZnWjFeFWo5muYuBxvkyJWzkBGsHJLUXm89qLiUY3xp7dtvWLBTTC
         OcKRTsjcN6IG6pjWJ1Z/xelj5jp+MDmB27OG8sNpFfB2r5wVQD3SqSYLk4BnpO1xlwmd
         sYwMXBQRoJGBAlfYvb4gMpjYx+7OFSxEgVHAEvj54Zn8kRbluj4nOkpfEr5c0g17Iv8X
         PM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788180627; x=1788785427;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xQtOWDkW+w7ybqaZBfV9HKOca4eSda4cgJxTQC5fkhA=;
        b=O04r0V3HW4Fni9UMt9H+5CwbydZq9CSvvH8kxSikJALHrjXJ7F3YEtOYkRYnE7pdvI
         s+9oEn6zVVjXSNFsPp/V0uPbbwYSMRH2q44glJ3FpDSXRpJkkKS8lFmkpM5/DjjTyE3l
         Jwgn2rZdviT6C+q/nDYdGaa1jvjmUULpIbMM/e5Ied+HQ0FKvVL4SpkkQjGwV8DZjO4t
         qLvaeUjyparR8KanWWZ7tykJoJzLzcyYNSKuSjmxikkikIw2SsXOfljjEgDd193AH0Bf
         UHewOaEIapdIUgYq1P3DDXhRqD9trzppFE/2ll+iMOdJ+Sq5fA3KxhGsNgHwoOlXwh23
         FANw==
X-Forwarded-Encrypted: i=1; AHgh+Rq3sDwDEbISJCm/vgVaON7OhOp4xeZxpT2fnJyQZNXfDOc6rkij14cLY2g2CGGbyiBm9dS4oBXoItEABOc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mfa2mYMncvj2DJFiAtEY2bfEaIAMGOmqKiXGzp6oHXDzAZky6m
	6U8HQg6PPkxKwhkZPEobeHS0edCxbbLpMEFg8kWDZB00dT3F1cbKyXQmN9n9Cvo1V50/VUo6Rji
	iDvGp+YO6/eE3WK33Q6NNj0QMdojIu3A=
X-Gm-Gg: AR+sD12pPcwwybUbZgMmjXdq+uSPll+KHpAVZKxid4tM02n6Q2SfqNOEDOAHKv8z27U
	/8/fJKOgNG4fEFm0+ATkevVsGkewpCz9TU3dLblxayrgMvT6XgGcIonCvsE9Paj/mwb+hEcSuAu
	p2ojKVG/Hwk4gjq+2lbHgknnSCGqUxVfAvvSTMtMKFLpwGqr9jkE3lLTl7QwhmmFvzv7Lr2uej5
	vVPKvRTtiy1CmbFWz56CX96kZ8B7tCQK8wjuuqhWD5EUxvhWAvbafh7L13hpdp6fTnr5XceTfE/
	y7ZT0Vp6W102knHGvqPKYSi/rnkFTECpz9dNotLlsHP90w==
X-Received: by 2002:a17:907:e917:b0:c15:f598:60c0 with SMTP id
 a640c23a62f3a-c2556c61b53mr1648394266b.4.1788180626731; Mon, 31 Aug 2026
 05:50:26 -0700 (PDT)
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
References: <20260830182036.284736-1-prasanth.padarthi10@gmail.com>
 <d60f234e-1b9e-44cc-9bad-da79e794fe44@lunn.ch> <CAMFFDGgTnNouukst3V1rEg0NCNMW-BZ6tM6+fbQc0zeXaOb72w@mail.gmail.com>
 <daf98fe8-70f9-410e-8a2a-042a671086c2@lunn.ch>
In-Reply-To: <daf98fe8-70f9-410e-8a2a-042a671086c2@lunn.ch>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Mon, 31 Aug 2026 18:20:13 +0530
X-Gm-Features: AcwNN1X0boEpGKg5x_16jtNRieTR5nthk-taojlLL5pnPEzmWybbo4sOjQPV9Io
Message-ID: <CAMFFDGgaEXdCdoi3av+HSLfUCZx-_0p4j7c5bjwiq_F08et2AQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
To: Andrew Lunn <andrew@lunn.ch>
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thanks. As I mentioned earlier, I had already found that the AST2600
has MAC-side RGMII delay configuration.

I will now check the actual delay register values on this board after
U-Boot has initialized the MAC, and compare them with the
corresponding U-Boot configuration. That should help determine how
much of the observed behavior is coming from the MAC-side delays left
configured by the bootloader.

Tan Siewert has also confirmed that the RGMII traces on the B650D4U do
not provide the delay, and pointed out the difference between the
SoC-specific delay handling in upstream U-Boot and openbmc/u-boot.

I will investigate that before preparing the next revision and will
remove the RX-only delay claim from the current patch.

Thanks,
Prasanth

On Mon, Aug 31, 2026 at 5:42=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Aug 31, 2026 at 06:43:46AM +0530, Prasanth wrote:
> > Hi Andrew,
> >
> > I do not currently have the PCB layout or trace-length information, so =
I cannot
> > prove that the board provides the TX delay externally.
> >
> > What I have validated on hardware is:
> >
> > rgmii: fails, with RX CRC errors and no valid RX traffic
> > rgmii-rxid: passes, 5000/5000 packets, 0% loss, no RX CRC errors
> > rgmii-id: also passes with the same traffic test
> >
> > This shows that the RTL8211F RX internal delay is required, but it does=
 not
> > establish where the TX delay is provided.
> >
> > Given that I cannot provide PCB-level evidence for the TX delay, would =
you
> > prefer that I use rgmii-id for the next revision?
>
> There has been a number of threads about the Aspeed SoC. It typically
> has delays enabled in its MAC, by the bootloader. The Linux MAC driver
> does not disable this, nor does it mask the value passed to the
> PHY. So you see many Aspeed .dts files incorrectly using 'rgmii'. Over
> the last couple of years i have been pointing out this problem, but
> nobody has stepped up to fix the issue. Most DT developers just leave
> the Ethernet node out, in order to get something merged.
>
> You case is interesting, because you are not suggesting 'rgmii'. So it
> could be there is more going on.
>
> If you look in the email archives you should find the information
> about where to configure the delay in the hardware. You might want to
> read it out to understand how the bootloader has configured the
> hardware.
>
>     Andrew

