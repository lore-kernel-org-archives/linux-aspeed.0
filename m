Return-Path: <linux-aspeed+bounces-3808-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1021061B24
	for <linux-aspeed@archiver.kernel.org>; Mon, 30 Mar 2026 22:42:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fl5pr5mwHz2ySf;
	Tue, 31 Mar 2026 09:42:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1029" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774840550;
	cv=pass; b=KYgs+SWAAyqMn6OjACTVTqh+yhRJS1fr1JTqJUw96GJ0KPOwGbUYNV7qjQ4TM1fXrLZycJtieCLGQdRrIORUJAHMzqn+M1oRZZ1UfJifekP8JzFaXienqon422Sl3XAI2fFRsuvgDcVTFHV0fM7Itua1p3GrNT/tAFGPZgOoFiQnyPZYfN6HpwnHxoYU5k6IY4xKh4mRuMqQEipKmkZyQMQn1woY4CVxCjjEM2wI8QsHtfyWpvLF/3HYVfFZj7uytzvMOmL1Qe1MwRKmtac6rYgUMnlE+7TRJ9B96KCrraCuscDQgMZ6l1jTjz+zDdJG7qUdgoUzGzzIHHPHoGKofg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774840550; c=relaxed/relaxed;
	bh=FVMXYmRNSK5Aq3wZtSGqZwzT1AZquu20CiOVo+iR0q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R13AUmLyL60BR6GJsPiGhubrTXoYeARMe5MWSfB/GhoG92XkG/zxvwqN4eOMpVb0Oa7fj/zvx4SgFmWLDLoXp3HeQ23qeYtDeAtYSeHKe1yCmolNpI3A87wxRSiN6JJZrZXSQLdKhMAf9IiF/sG2FhgTAr2LVNMwO5fviEmeM8M9LfNrOZLIx314tMFq53XrYr5JQyI0tmj0ydC9+FPeTHm1jL5zGyBtkLHGMbu7ptGheh7ru1kEDxb5LThenoEZuIpGCZWwbfG43ejYzFcuxOMFVLxfoOsAts8nflBESHpTLlOqE5kW99IhssqBFFdvuUa+vTr/jniguHT5Ze+3YA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LvWAwBwV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LvWAwBwV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkbx12p0kz2ygG
	for <linux-aspeed@lists.ozlabs.org>; Mon, 30 Mar 2026 14:15:49 +1100 (AEDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so1074826a91.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 29 Mar 2026 20:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774840546; cv=none;
        d=google.com; s=arc-20240605;
        b=W95bZx7J/z6xVqycpbELwPWNPIIwbDHd884Lw0nA41NZCRVs/uulz+PqzOIBVECxeb
         p9BZ1p9S5k5be+XJh6X+Mj/fP01IXFAb/3Q2/4qgY3VmFi9FZy4YS8JBZIBm82LXLmAk
         jekCRXnWt23FqbLrKU9lf+U0BueXL5mQXdTH2BDUogmRxKsYs4WJUqm40E7N3eh8ay84
         wxlEI4wJTD8dgqY+xlhC9+Rr+GQtBap0K5AK6Bh9erDN7EgDx8npLZIiJ4huy+iW9RKL
         pOL5g6ytWj2c//XMflSQxydjKK4VkDlarZEu83qgk4AXrF8n9rzn+IIm0RYwYdPbiu5G
         8TDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FVMXYmRNSK5Aq3wZtSGqZwzT1AZquu20CiOVo+iR0q8=;
        fh=PFWV2Gjyf9OiAaRksTjXl/D6wMD5Ds4VS5EwQ58O5L0=;
        b=I5+X6KPnSZWrtQcYWo3HTpevgJUhdnVCQ/n9aD83o+hKS/6lYCeTonqe40pQMulang
         xn8MB+h4ZDoVNpTib7faMc87poY7+U8Cc8a5oIp9XxlrZyb8jP648V5NolMZw3I7wYu1
         Kzcii7dBKxscx7YKtPjoMexUHHu2fQELSHIHlbEZS5ELx5lCNXjlk/DewTmw3ZjCwpUe
         JxrZQMb8JHzjHMVUJv2s1HlbU/Xm0NbsK1M3d0fmz59ByBiM9sPBKVvR1CxjdMJ87MbD
         ejJs3ZsdmMrXWpMxHPsTXxd/izA7FbkLSHcn7x5ihctPQd1GOZCDzUgqEDpgqMdJDRzR
         EFbg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774840546; x=1775445346; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVMXYmRNSK5Aq3wZtSGqZwzT1AZquu20CiOVo+iR0q8=;
        b=LvWAwBwV4fpfpBGRW9XXWjiwAPhLUReA4f+Yn9zO70yJ9jQkMBwn0cKR/cBSAOUrjX
         onEb0aLLbDRO65SW4IghFobHKl7l6P2Xzcb3CEpCMiae+iPjzyV/5q5jgkADj0ycu0va
         e0Rl1xhYzy3zUXLKZl/D1BMVYQYsnPZXQI6YtUPn6GPcsIP1ag8lnGgEK2jnbsLtr/kO
         /yt4oancKRdFHgnPzUK2+3yNHVU2FkG4jWa+3PAA4ic+BT7/tfAJAxxWAW5LSlywJGJR
         LZTRHkQRr8ySP52TX73pmJOAQ8IahKpQfVVmAtxYUvtccOrWTdz3fd4/9mA6VLi6lcqY
         i4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774840546; x=1775445346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FVMXYmRNSK5Aq3wZtSGqZwzT1AZquu20CiOVo+iR0q8=;
        b=OivGr0mVxt9aJSifEDmRy2ojiZNJtviQMGIRGPmWhXJRIqah3EefMls3pxD479hmAX
         UHA4jrcgOTIh49JoqFnIKhjrBI8RbNd2sSuiy6pF6CT32hs58VmLSltp0eI1hsILvwxL
         zWR2ZvhP2PiPust4DHZ6oXPq3Nugf8/Vdel2dyUjS853cg3XKgF6MKGSI6yt5mO5RjjO
         YAxYsxxZGeGTCpT6OlxkueIyScxOE9awg+Wjsjb79JPr44KXYrwmcO454vGcEWccg0gP
         E4llsNmmcWZSY+Mvvh8XNpsE46bxueiMA9I4yx56W6vcTiC3qi2SoG7d+Wr4DjB0GxUe
         jUQA==
X-Forwarded-Encrypted: i=1; AJvYcCWHigH58OgezjLVAXXtjOTPgsaPfAOe4hLrE3HARqWmBsnQNSmYsCD0XcBpLMSgVvRjOJKTTn0e2hlt3nM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz1DJ24oWSg3ZeSoCGHr2IzrA928pNq+IptV2C0i2rGZIeepF0U
	6VrETldlX+TadIGVJIW79YgcSqBFy3XtKSC1ur4ztGkjQpvl59+xRR8JwWwbWEb7M9y2TRTlSAX
	nQ3RbbOK1blVBH8LEwwoZB281FqsCcYQ=
X-Gm-Gg: ATEYQzzQrrl0Q85gYJcHaPOWa5cuMEcNDjQHR4JJsTvg30Dx4GzstjFjtcOO39o4EqJ
	zWc8842MfJpUUu4DdqSrfG6KjgTbEi3QCrDzjgdQHayY+EPk5rB7OvppN92rUsnYAcus8nxKayC
	nVeMhEmAiV1v3VsDYnRJjVd0KZ0EyOoJ3Hv5CXEYAFnjz0ZXd1lMgGueQ1B3HT4rrf+4QCYuT8B
	haRpNp3XU/czlehtBoqFe2QF6+gPoLj3uoX0enP1X7/Kk0LKQ/reUx5AWzXh2L60pJj6p0tnQvC
	S41pWIc9dUbLJ7lbJQc=
X-Received: by 2002:a17:90a:38c6:b0:35d:9d4f:f595 with SMTP id
 98e67ed59e1d1-35d9d4ff8a6mr3077625a91.17.1774840546438; Sun, 29 Mar 2026
 20:15:46 -0700 (PDT)
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
References: <20260223-yv5_revise_dts-v5-0-fc913e902488@gmail.com>
 <20260223-yv5_revise_dts-v5-2-fc913e902488@gmail.com> <73ea41bf341df0e3215c58a029c9ea2386c4ef8a.camel@codeconstruct.com.au>
 <CABh9gBd3b9TB1-s=Gq1q-M8bX+4UioXePUF0DPVrU2N3N8S9yw@mail.gmail.com> <d7794f74b26bbc1ee0a70e39c5671acc018f80eb.camel@codeconstruct.com.au>
In-Reply-To: <d7794f74b26bbc1ee0a70e39c5671acc018f80eb.camel@codeconstruct.com.au>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Mon, 30 Mar 2026 11:15:53 +0800
X-Gm-Features: AQROBzAgZ9-0Ybc9ZvULPVMA1y-kfdj-DVMBBwWYIa1fxoX4faQR_SIhsXqj-zQ
Message-ID: <CABh9gBddmoLWyJpuKr8ieWCCHXgPPNn+zCS2WDkUn8x2NBkzqQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] ARM: dts: aspeed: yosemite5: Remove ambiguous
 power monitor DTS nodes
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Amithash Prasasd <amithash@meta.com>, 
	Kevin Tung <Kevin.Tung@quantatw.com>, Ken Chen <Ken.Chen@quantatw.com>, 
	Leo Yang <Leo-Yang@quantatw.com>, Jackson Liu <Jackson.Liu@quantatw.com>, 
	Daniel Hsu <Daniel-Hsu@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 2:07=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Kevin,
>
> Sorry for the delay.
>
> On Mon, 2026-03-09 at 11:41 -0700, Kevin Tung wrote:
> > On Tue, Mar 3, 2026 at 6:41=E2=80=AFPM Andrew Jeffery
> > <andrew@codeconstruct.com.au> wrote:
> > >
> > > Hi Kevin,
> > >
> > > Sorry for the patchy replies so far, but this series bothers me and
> > > other priorities keep bumping it down the list.
> > >
> > > On Mon, 2026-02-23 at 19:17 +0800, Kevin Tung wrote:
> > > > Two different power monitor devices, using different drivers, reuse
> > > > I2C addresses 0x40 and 0x45 on bus 10 across Yosemite5 board varian=
ts.
> > > > Defining these devices statically in the DTS can lead to incorrect
> > > > driver binding on newer boards when the wrong device is instantiate=
d.
> > >
> > > There are effective methods of maintaining devicetrees for variants.
> > > Why are we choosing to remove information about the platform rather
> > > than use existing techniques to properly describe them?
> > >
> > Hi Andrew,
> >
> > This is due to hardware design changes during earlier development
> > stages, and the fix is expected to remain stable as the design has
> > matured.
> > Could you guide me on the best way to maintain devicetrees for
> > variants? Thank you :)
>
> My expectation is your platforms move through several design phases
> prior to (mass?) production. My suspicion is that you have sent a
> devicetree for the pre-production design phases, and you're trying to
> evolve that one devicetree to match the design for whatever current
> phase you're in.
>
> So, ideally: Send a devicetree only for the finalised design. Don't
> send devicetrees for pre-production designs.
>
> If you feel you can't do that for some reason, an alternative is to
> have a separate .dts file for each phase in the design process.
>
> This may sound tedious but it doesn't have to be a burden to maintain.
>
> For instance, you can use one or more .dtsi files to describe the
> common components and relationships for your platform. These .dtsi
> files are then #included into .dts files as usual. Often .dtsi files
> are used to isolate different hardware scopes (SoC vs board, for
> instance), but we're not limited to that, we can use them for the
> purpose outlined above too.
>
> If there are only (very) minor differences, there's also the option of
> #including another .dts file. From there you can adjust properties or
> even delete nodes where it makes sense. For example, we maintain a .dts
> file for the latest revision of the AST2600-EVB, but we also have a
> separate .dts for the A1 revision with a different regulator setup:
>
> - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts?h=3Dv7.0-rc5
> - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dts?h=3Dv7.0-rc5
>
> Any of these are better options than this current approach of trying to
> justify incompatible changes against unclear design boundaries.
>
> Andrew

Hi Andrew,

Thank you for the guidance.
We will submit devicetree changes for the finalized design and ensure
they align with the hardware to maintain stability and avoid
incompatible changes.

Kevin

