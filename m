Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E04606A32C
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Nov 2026 03:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fk87PFjo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKnzF0v6wz2xPB;
	Thu, 05 Nov 2026 14:36:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::112b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793849784;
	cv=pass; b=N/D7FviwJz3OoDYmp1+2T5EyW4SPU6aw1egX6Nu5dardLH17bezZXGdSpap8H3/F7wlU40vCCXKdo2alry/IdVpnIwZ0PnAGxh852dADmRAJrXeLx3jjrm5M7tCvK6GDuVC29MUhYhuj2blUKq2hoNJmM2kWY4pBylGBdMu7SDNjr4fYdS0YpmaWJE5hDq9jAeDmds0Ga6jAZcUlaP2gkAJf86qkwvuXzwgNi+zp6v3zMrXIpdbqVlFttxL+8i0UKjwrwX7EUOUXu9sFqTn/IPCCfB4vVldfHjKrot+OFPORwvSoEDJNtS32H5EW05HFROT+qwLtk6gYUkCCnfZAWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793849784; c=relaxed/relaxed;
	bh=5B9lX6DZI5S1tAfFM57GnAbiozq6dSyTVBcFVL3BszE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdz+C10NQF9MiyisOKamvYfP++GpwZrXoPO79HxpLioZBDBiA3hXgYS90CXc/2mcLe80idLP3Hxn9puSR4v2RvtGrXDLwMyOoMvmo2ot7TSrl8eW5+7enEj0BkBTgIxfQuMR06mroXdtm90/pi+rNl0RbiuyhYY0k2i/2LC8FnRjeAdnUCoIDdExG/P3NmKp8vEhcU0/buxDsFMCZgEKateIJBwBJHlVOJ8D3/lh2mNLwo5Usfw37n/Mmxx1RBh8Gmg2RBTS98Rc6Ndtg7dPGMBIgrOxoY2qAA1iv98MnGqeSRFCGY+rGevrXXqJ7QnomzvYwSkYqOLpFPhXUn+m2w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fk87PFjo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fk87PFjo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKnzC65JMz2xNC
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 14:36:23 +1100 (AEDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-8b0d126f631so15578117b3.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 04 Nov 2026 19:36:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793849780; cv=none;
        d=google.com; s=arc-20260327;
        b=lpzl3qKMa+x0cO8cUZnpDTu73j1RPkDhIYrFvdfd5hIPf27B+r56ATJRblMQSFgNe/
         mWFOPlbHFHTxmhf4K9H5nUknaPCJYn4agBmBJzzog/ZObnehr9aPm/MospQMY37GhqL/
         gie6++KdOnk+oRrGnQTPQ3c/6FIU5QX4ziVD6Z8eN/9+s2Ah7t0djl3Q4AJdTObEb6cD
         3nrKLbpAd8qs7auBJIh6956GA/wGbcs+T15mGQB5/gTiBn885zvjz0YmeZHlGk+Z9ZZx
         QutsDX/Bb2uuaw21Rq3zjUd2RXWONyp7aYhvJ4wjriBMmICRiR69t5ctwtyutPdFAMRG
         vFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5B9lX6DZI5S1tAfFM57GnAbiozq6dSyTVBcFVL3BszE=;
        fh=AiHJ9FgHn62ndxglEgolMO6X5FDI05Q+chNTNHmWypc=;
        b=d8tQUlNvDidbjjrYXtvA+r/q1tCMEWeG2mZzTwiQKXs1TEpAFiK3SRc8b5gRScckHv
         XWmWDGkzclYa3q1v81UYa+MOW66w3Ez4VH2Ou2/P3thfK5Kb5i5/jUqKYD2URKNZI9OG
         8phiISUG0bwtoZv5OvU0m1q4DKh7SBiciMYTo3cYs3yiq5tYI/upHezNYBYClc0KlMUN
         kL7mA8MSXklB/caoRau2rLt6R+95b4WOxniglY5T500/BmfbiJRGkA8U29qXP00AsdhL
         Za2+fDLvvfYcN+4cOGlw73adzjdi7qiElmNNavW8EIuPBi5glYfwlQBW0bKotm6Qh8VP
         Rc2Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793849780; x=1794454580; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5B9lX6DZI5S1tAfFM57GnAbiozq6dSyTVBcFVL3BszE=;
        b=fk87PFjoc0hYsGNiAKbr6MaBK4qdErtbMH3PxXexgdlzXXKcozzL04OlVFg2Ab0Q58
         CqIU48JCWRg/s5NOZTIwtUFu6YQjircETqbSrGDUhkqLoaMeKKyn6gFLL50ZWjBf2ofn
         bLsXmMDJWKy2LUY1I7n5k/uO4jeuugcBFf8Gq634dZSyl/xYcNodcXzBIAae/ECUMhoJ
         tjKM298brpFVl5++D8WBLMlCCro7Q2i5ybK+4REp/BCnILJ2uBqNdEXSHul8oAWlCkSX
         qXvyOyYdlr2E7iEQ6GvbC2PH3A10QFCGvrORA3cBjtg7vLeSUZwaaOE4N9WIaQVFuHwn
         ZOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793849780; x=1794454580;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5B9lX6DZI5S1tAfFM57GnAbiozq6dSyTVBcFVL3BszE=;
        b=QhbWVsDCMmnJQpL998SX/to9qqXd2zRydjdYcO59kYypZHrssE7V5IR99uaQpCDgmI
         vIErkEmJzxLhZMDPt/pqDBxjCS/vIm8u2cr9sfGiNpCN17c2ZFzY+8bxsDVH/DT0ZKZp
         EZPm3tZEyP8rj4pSfeS4JAr0oAJNh1YLPAKBJxacn53HUsxaNVWFr4NgO9IkDyTiRx2X
         pmdYrC0uCRWiZpZoZYNBtaaDZqagiHXdgRaMET4IgNI6z0nsGArun7sxml1g1YHpqByA
         0XBvajEJbuG2BStCLAc+Y0gCavX4yM6p2RNDHWUfGtwI3557O22M7aOhrbfEZ2IOU3vW
         nyZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdhEmDxJDsEvhi5soEKkM/4mF1AT8V0aWBxQBrUyZnB5QjuvfId6WJ3dgsIh3K+3jfG6HnJr8nSg87acY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9VFJ+3SEJD3ffMhX1FBr1u4/1jJolE1wA4ZHheA3777P4Ci88U
	N6FNux8pXZP9R53UIuJU/zmNThOs3Qb9IYcKYqs4s7YNwKGoIwQwteNOBohZAs8vg8Q9/XN7OVG
	ou/il4bv11rbEf5jlRwYseAeVk60K1no=
X-Gm-Gg: AYBFou1xCs+ClOE2kt2lAoUtL5D2ylzolrraOZWc6pvDrBeoQJ9ZtCAqiitQ5Aa5DTf
	6PZQnVXNe9RpOHte+1a5qEcnS9X2/t2QOtNXnk/LYnGHmvVvtAUiUopUvm8q/MO/3PrncKvRk/i
	ymMD0BHjCx6bL3wZrce/Ut2nO/fdRxAZBYE2akmwwU22lnt7/PBScUkXp5KAPyHPIxIUZdfM/kF
	i0A5NL+tho6Gy617a6Z5iZVqHYmP/h+0ISr/GyWPtQ0YBhTp2How1KIa3/2J4zSzw08DLE6pbab
	qZaOviCAVUbyEmMX3qpZeoWHBrvr0ur8QNPFO1pO3KUqpc30rHVMc7wDut3q3Szq/HCg1N1DxL3
	JxOiEvlV8GBf+TpsVw9aE7ouTdzCMGXsPcbpGAQ==
X-Received: by 2002:a05:690c:e3cb:b0:8b0:e385:edc3 with SMTP id
 00721157ae682-8b2b6719311mr132765087b3.33.1793849779988; Wed, 04 Nov 2026
 19:36:19 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015035118.9495-1-prasanth.padarthi10@gmail.com> <CAD++jLkx4oQ2ZuUSUQE1Qtrk-1XSMdnDjfLG0rrOm=gt9VD3VA@mail.gmail.com>
In-Reply-To: <CAD++jLkx4oQ2ZuUSUQE1Qtrk-1XSMdnDjfLG0rrOm=gt9VD3VA@mail.gmail.com>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Thu, 5 Nov 2026 09:06:09 +0530
X-Gm-Features: AclHuK9YMOK-xz_gxOFW3IfSoWRvHeDrckSu5fgcWiOJM4mFO9QGiU-P0B7A4RY
Message-ID: <CAMFFDGhD4K6PN8G+c-hQAL6RG9sVkjo6SXHB5===bYswHh0aTQ@mail.gmail.com>
Subject: Re: [RFC PATCH] pinctrl: aspeed: Handle GPIOZ6 pass-through strap on
 GPIO requests
To: Linus Walleij <linusw@kernel.org>
Cc: andrew@codeconstruct.com.au, joel@jms.id.au, brgl@kernel.org, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Linus,

Thanks for following up. This work is still active.

The October 15 GPIO-request callback was superseded by RFC v2,
submitted on October 22:

[RFC PATCH v2 0/1] AST2600 global GPIOP passthrough handover experiment

October 22 RFC v2 cover letter:
https://lore.kernel.org/r/20261022024314.48623-1-prasanth.padarthi10@gmail.=
com

V2 transfers the global pass-through selection to per-pin SCU4BC
controls before pinctrl registration. It also handles SCU510[28]
through SCU514 and restricts affected requests if handover fails.

I have retested this implementation on B650D4U with a newly built
image and GPIO-only x86-power-control. Remote power-on, remote
graceful power-off and physical-button power-on passed, with
power-good transitions recorded in the journal.

SCU4BC remained 0x30000000 and SCU51C remained 0x1c80 across the
remote power-on/off tests. Electrical continuity, mixed-pair
forwarding and fault-path behavior remain unvalidated.

I will verify the requested base, rebase the October 22 version
and resend it as RFC v3 for renewed review.

Regards,
Prasanth

On Wed, Nov 4, 2026 at 5:49=E2=80=AFPM Linus Walleij <linusw@kernel.org> wr=
ote:
>
> Hi Prasanth,
>
> On Thu, Oct 15, 2026 at 5:51=E2=80=AFAM Prasanth Kumar Padarthi
> <prasanth.padarthi10@gmail.com> wrote:
>
> > On the ASRock Rack B650D4U, requesting GPIOP3 through gpiolib does
> > not provide working host power control when the GPIOZ6 pass-through
> > strap in SCU51C[9] is set.
> >
> > With the existing GPIO request path, SCU4BC reads zero, but a host
> > power-on request through x86-power-control times out waiting for
> > power-good:
> >
> >   SCU4BC =3D 0x00000000
> >   SCU510 =3D 0x00000000
> >   SCU51C =3D 0x00001e80
> >
> > The AST2600 A3 datasheet describes SCU51C[9] as an additional
> > pass-through enable for GPIOP0/P1, GPIOP2/P3 and GPIOP4/P5 when
> > SCU510[30] is clear.
> >
> > A diagnostic experiment that cleared only SCU51C[9], preserving all
> > other bits, allowed the same GPIO-only power-control implementation
> > to power on the host:
> >
> >   SCU51C: 0x00001e80 -> 0x00001c80
> >
> > SCU4BC and SCU510 remained zero. No per-operation THRU1 switching
> > or additional userspace delay was required.
> >
> > Add an AST2600-specific GPIO request callback that performs the
> > existing GPIO mux configuration and clears SCU51C[9] for GPIOP0-P5
> > when SCU510[30] is clear. Check register access errors and verify
> > that the strap bit cleared. Other GPIOs retain the existing path.
> >
> > This RFC handles only the GPIOZ6 strap source. It leaves SCU51C
> > unchanged when SCU510[30] is set and returns -EOPNOTSUPP for
> > GPIOP0-P5 requests when SCU510[28] is set.
> >
> > Hardware testing on B650D4U with this pinctrl candidate confirmed:
> >
> >   - Remote power-on: power-good asserted.
> >   - Remote graceful power-off: power-good deasserted.
> >   - Physical power-button power-on.
> >   - Physical power-button shutdown.
> >
> > These tests used x86-power-control with software button forwarding.
> > The earlier board-specific SoC driver, its DT node, custom sysfs
> > interface and diagnostic boot parameter were not used.
> >
> > This replaces the approach explored in the withdrawn B650D4U
> > power-passthrough RFC. The new proposal changes the existing pinctrl
> > driver and introduces no DT binding or userspace interface.
> >
> > Feedback is requested on two unresolved issues:
> >
> >   1. SCU51C[9] is shared by all three GPIOP pass-through pairs.
> >      Clearing it for one GPIO request may affect forwarding on
> >      another pair. How should that shared control be represented
> >      and coordinated with existing mux ownership?
> >
> >   2. The SCU510[28] enable path has not been validated. Returning
> >      -EOPNOTSUPP is a limitation of this candidate, not a proposed
> >      complete solution for every AST2600 configuration.
> >
> > Is the GPIO request callback the appropriate place to handle this
> > strap interaction, or should it be modeled through the existing
> > signal-expression mechanism?
> >
> >
> > Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
>
> I don't quite understand the status of this patch, if it is still up for
> grabs, please rebase it on v7.4-rc1 and resend so we can restart
> the review.
>
> Yours,
> Linus Walleij

