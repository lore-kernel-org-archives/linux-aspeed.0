Return-Path: <linux-aspeed+bounces-5196-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3F0CC6B39
	for <linux-aspeed@archiver.kernel.org>; Thu, 15 Oct 2026 16:00:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5CTL1S1Jz2xMQ;
	Fri, 16 Oct 2026 03:00:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1131" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792080022;
	cv=pass; b=SHJAAguf8g985Famq9CR8Yq7uMiAM14fMaPRyIGYTHekQ4NfjQ1wwxprNBll2+AjHFVugFuXpEuBCEsephrfg7/IwzVjVXywTDTooIKpJXXd+bYMJz2FjgJChJfpuGr7uphAo4gTKtHidg/Ev3w9YYrk+J7v/VeSrNE/HS2+9FGbfPM5MGqsSSF/s+eWEAy3cOBQ1UtvQMmEdwZMDxmau7Hv5qHhRBiiKeA50YiJ7cMhCiHmglyiQTrQH4nAAWN+v1e0GPRCNndr91cxqkFAROmAi+Ishqx76PiO2dbXBPg9EiJycXoJN2QefXfN1pwo+/Pcm23Q+tRFk8ueR/DnUA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792080022; c=relaxed/relaxed;
	bh=EpiamPpg7tsWlSrLw5y7LmqhMB0UGS6DfO66CA4pLkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8aodpXPn/GL+Yr6aDhhFg3sEyNDimmUxyXUSeOLy4+D5886Rl9fE3LQP8+eNv1cL68xqwQOEyK8KuzO1C8sar/RYAGS0B0t77lIG6+hCkYX0nyX/ShfeSOoLzrQKMS7cImQw14hVmNdBVPNyGkOw67tuh85iSNLZwQLkw5PMqvynnTJLvtZ38n04lzH7Xv/YoPX4V7/9apuuFS4ReU4X/hy1eqPAsvz57diyjmXOeG22KdFnq+fyAIFh1Eo2URbWm4yE1Nn5DPV6qtssv6XywiYRaGV5+i9ZgiaGxDswLsPtC7y+EdxlTHJmg0ewz1MbMuVyQcuVtaMOJT5/8ucrA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fB/jsV6a; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fB/jsV6a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5CTH6xZ1z2xLf
	for <linux-aspeed@lists.ozlabs.org>; Fri, 16 Oct 2026 03:00:19 +1100 (AEDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-8b09e07e149so23302897b3.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Oct 2026 09:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792080015; cv=none;
        d=google.com; s=arc-20260327;
        b=lNgQ0HOsTJFWLLMkQOGUkvp3gJ+Oj0Ga5UOocfwYpcNo19DBU4aQ9vH9X+ULN6J9o3
         Oklwl//kbyWUBsYrhr89H6TpJEXwUgAcFRiv2S8vc/4tDIeZL3J1ZSSPY+tVDmhocXKu
         7QCUUbXldLFOYYXtOLrswWWyqcTHXtDGTvpSdnv/Hfp+EvTL/qsVojLZeW+JJ9R4Mr+l
         w7cXimTFvCJhLxU4RIOAWiqepbUr55dSGToFBO/LkMfT0JONVbalc9okzIRid40OVxGc
         fy5wps1B65YOcndkP4L6iG4SmPBpUeY/2EPfBNzMHGZkRo+ioVI/koa9mSEdxu+GL7g7
         5ckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EpiamPpg7tsWlSrLw5y7LmqhMB0UGS6DfO66CA4pLkg=;
        fh=/QTZIHYg51PM8am9qodHSNB1n+tesHxL22yFLxHdoR4=;
        b=iBQ0xn7+uXWf/Za/Z51Rb76HF2i7SLlJI2ahySKowjyhQJ8uvU2ZNpxLNo/TeaYiGG
         XTbu8lLUF0+GFqraw/h64MLrQRGjHzoDaHpE6dH1b6XtcymvbtFcONmKXxYO29pGryvW
         Xv1MhzOLQH4VIqVH7N+cm/zgJPqflUJjq7xc2tVX7x0WEuAmmc/UFE3u9tIDWoIE6qAv
         Y0J3eGVT6gyL5dPdKqsFPQ4t3P6LRVBxn1O592fdTsdy3BEMaUXxkIn1saWcPIeOqkqm
         RsmWIoPOk/aP56VmoW64KnQW7w2N9xUYJKYY3hBMsqnCyOSnW4LzM7WlenJ1ygMPXoJF
         aatg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792080015; x=1792684815; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EpiamPpg7tsWlSrLw5y7LmqhMB0UGS6DfO66CA4pLkg=;
        b=fB/jsV6a6afiS5qS0MtOUS8YYna2SzSOtSqhJc1CYci12/JVAyWTma9hIuDh6wDh0B
         kr+r6SLDB2rAB2vlq7hpGxYueaadu7PeSexbCKwtgiY4HURC8axtwPlX8TOZuskOCw3/
         HKZawnwKCMmhOaOcewYzqdINIa8nk64Os6T5o3l8irJe767LHuPqJIOB7A7QVtnHIQYr
         9/rf8VHDziDgSr07Vv3ygYAr+V1m7+cGuEjsK0ggKStY+kLJSoNvKedFqf7aTwu6NRKP
         jvIZBwqMRkQkl5R0c2iQaNLjS7lirs5dBfHXRymYWQTYow4XGS1qZRPWUiEZgGfa2/UV
         s57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792080015; x=1792684815;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EpiamPpg7tsWlSrLw5y7LmqhMB0UGS6DfO66CA4pLkg=;
        b=NkL4GqM15N3G4y8zI/CmneOE6hf4dcTu4UemqxinTFL23KcaSm+MM/A2LEYOW+PYBR
         YP8ihD8WwxdzZMI+BbbPOmNvm8lnjVVNSowseFrStK0ZfO1KrYvnI+basbvgzIYL5uZK
         BZQ/AGftlaqK1FI7AmQOojC4Fiqs7iQ8pZMBK5rvG5QrdXqW+yovNB8pgx4+HDIvIPBd
         L3G+vp6shkHBor303hAK4W1g7ZqVblSqoJe3WQMO0LpBU0zC1UiPrw/sfirR/pa2feMz
         PsPV8oPemWBw9U7rNtLW/+/AJlCuqX1ot69gCa6rUsGNPLHFlzGni4JXoGVNba3dneTr
         ATDw==
X-Forwarded-Encrypted: i=1; AKwUvBzfRQZbtKxPzvqG90tznm51d4pWqvMeE0P/xh3h8O07ck2c2ZvQWd+oCyM+Yb+psP6t0+vvVi68Z2yPb4Y=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLcXlCWx37+SW6Ut7SJQ43Bg1xpVGpxeJ+socTcy1NCp2sxOL99
	OFa37YYKkh/ZMrgGftPHlvRMBJirSc9spFImhYrRuj/m8NUjWpHy88NMwgbQEcH0S0b3qQA4v4M
	jJmlNYfy1FMRCnF77pUS3wtB0uHimjik=
X-Gm-Gg: AYBFou3K1tS+nb4761F3Rq8rvXx199m0knH19b44aJz5jta5HF8kS1ixyBz8Di5YlXZ
	kvkgFXsJ9az71xIYdOQICsssNP8Ngtt1Dc+vmAlfAZcpJySWXS7vQBfLvrgmFrnT8k0jhTpLmf9
	p/96XS2vJkiGhXpzMJww3OG4x/uky6Z6kBDbbV4oA6DTehH61wBEa5s7EagPGqwP52DWX6STJKX
	U39A1eF05xHcfdYI186nzlAmCI547mJuw4ypSQi2kzPWzJHXC4WbHvgWJnOmYfvmZDTfi3Zu5wj
	hCOEsLLE+u//1jco8q7p/8/pzebljhOj0gUWHwOxorVlyiJaFU69juvypQ==
X-Received: by 2002:a05:690c:f91:b0:8b0:db26:88ae with SMTP id
 00721157ae682-8b0db268c9bmr5613747b3.43.1792080014084; Thu, 15 Oct 2026
 09:00:14 -0700 (PDT)
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
References: <CAMFFDGh6XwYD-axu3brX0Tdt3PteJHHGo6oJaghzpvnEyzT58g@mail.gmail.com>
 <OSQPR06MB7252CC7FC2131D45457A1FA98B962@OSQPR06MB7252.apcprd06.prod.outlook.com>
 <CAMFFDGi-Zzwk33Rb2LPVOSz+XJa51iBQ3ZWEP6mLg4C362F=VQ@mail.gmail.com> <CAMFFDGgv0+sUL4V4itKw3pezB4MccYr1rGwrS6F0qwD=0HLB0A@mail.gmail.com>
In-Reply-To: <CAMFFDGgv0+sUL4V4itKw3pezB4MccYr1rGwrS6F0qwD=0HLB0A@mail.gmail.com>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Thu, 15 Oct 2026 21:30:03 +0530
X-Gm-Features: AclHuK_aaHC138fG0PxG0zW83HUUPVrTWcZnddhJ4Q2cRZHfJqvDEmtIQg3W568
Message-ID: <CAMFFDGjXyHVthH33ctkCYLu1LUFB3-b3HG2hQbtOyT3tSvy+bw@mail.gmail.com>
Subject: Re: [RFC QUESTION] AST2600 GPIOP2/GPIOP3 pass-through with gpiolib ownership
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Further testing shows that per-operation THRU1 switching is
unnecessary. With SCU510=3D0 and SCU4BC=3D0, ordinary GPIO power-on fails
while SCU51C[9] is set. Clearing only that bit allows remote and
physical-button power-on/off using x86-power-control software
forwarding.

Should this strap-to-GPIO handover be handled by AST2600 pinctrl,
preserving other pairs=E2=80=99 routing, or by board firmware initializatio=
n?

On Tue, Oct 6, 2026 at 7:24=E2=80=AFAM Prasanth <prasanth.padarthi10@gmail.=
com> wrote:
>
> Thanks for the guidance. I continued with a private B650D4U experiment.
> The experiment now reproduces the exact vendor sequence:
> SCU4BC idle:                        0x0e000000
> SCU4BC transition:               0x02000000
> GPIO123 pulse SCU action: cleared
> SCU4BC restored:                0x0e000000
> On real hardware, OpenBMC now successfully performs:
> - Host power-on through DBus.
> - Power-good assertion.
> - Graceful host power-off through DBus.
> - Power-good deassertion.
> The private implementation is intentionally B650D4U-specific and is
> not proposed for upstream as-is.
> Given that THRU1 and GPIO123 are mutually exclusive, what upstream
> subsystem should own this temporary transition? Should the
> power-control consumer coordinate GPIO and pinctrl states, or is an
> Aspeed pinctrl extension preferred?
> I would appreciate guidance before preparing a generic implementation.
>
> On Mon, Oct 5, 2026 at 8:33=E2=80=AFPM Prasanth <prasanth.padarthi10@gmai=
l.com> wrote:
> >
> > Since THRU1 claims both pins and is mutually exclusive with GPIO
> > control, should the power-control consumer acquire GPIO122/123
> > normally and select a temporary pinctrl state that disables THRU1
> > before driving GPIO123, then restore THRU1 afterward?
> >
> > On Mon, Oct 5, 2026 at 8:04=E2=80=AFAM Billy Tsai <billy_tsai@aspeedtec=
h.com> wrote:
> > >
> > > Hi Prasanth,
> > >
> > > On the AST2600, the THRU1 pass-through and the GPIO123 output share
> > > the same path and are mutually exclusive, they cannot be active at
> > > the same time, so having the pass-through pair also controllable
> > > through gpiolib isn't achievable in hardware. This matches both your
> > > observations.
> > >
> > > Could you help us understand the use case? If the pass-through
> > > already handles the host power path, why is switching to GPIO control
> > > needed at all =E2=80=94 rather than simply keeping THRU1 enabled thro=
ughout?
> > >
> > > Thanks

