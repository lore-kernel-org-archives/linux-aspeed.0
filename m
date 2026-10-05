Return-Path: <linux-aspeed+bounces-5138-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E52CA5FFC
	for <linux-aspeed@archiver.kernel.org>; Mon,  5 Oct 2026 14:49:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hz2Mn0yxzz2yTP;
	Tue, 06 Oct 2026 01:49:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b12b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791211749;
	cv=pass; b=Z6IwGRX0+el0LpFWzl637Vb78l2EaHYzxzlV8OpMqIT7crKgFztXP9TDhBlE6O2hqDqR5Kzxn+cdQt0W1oC7BQwbdeeKoZCwKxqgAIZdb2wSOg8sGzsORrS2wAx5fBng2VrvJLCTAOJEZc4NkOZ7ARUv3kW5NiSev55UkbokJy2G5Umi8GXMa1uV4S+cPMWZU/j0gYgCS5fwxDcCq6VqjzACk7S8yaJjSeWrvbJWMp1ihSZY0CzNPUh21fyE049ZASrAl+P1Os+TwyebOO8Kd4huIhf7e2ZuujmUVwI0yNqJ5cGfApTXOaSonfLKnYr7cRJwCMAHxX/Gq9+xlGJjjw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791211749; c=relaxed/relaxed;
	bh=fB2EelR9jUud/JtAYG8OEIPQSZV00QMO8xof8XIZq/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOy7cj5uAqu6mZk853likalrc8XQTFAVxduJsG7IZXT5bJ1NPMnMXKkNjaL111Aq4Bd5cMG2Kt2HNCLrlQGqfh8NYe79HLMUIni6iQFxReDGMPLDRkilgM0VExovtx0X9iqvjwvTUv92O67voufHZzlhMkcwe0TI8/cocdZx+Je93UZ4+PKbMHn9mhgmnFwixks2Bkms1OSZcNM7tpIfDni1hUxaRdkOboaDlM1DN7EIpOxQKk+r+77/lwjprTxY1QqfwdScU+Qr7FCSIhAkrnxR/FdEcqI5uQQlujBtrdENGZABV2Ep49201yhoif03vQZO2gYGGf5yD6aSrcR0Ow==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CQ1SDXcV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12b; helo=mail-yx1-xb12b.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CQ1SDXcV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12b; helo=mail-yx1-xb12b.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com [IPv6:2607:f8b0:4864:20::b12b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hz2Ml25RPz2xnn
	for <linux-aspeed@lists.ozlabs.org>; Tue, 06 Oct 2026 01:49:05 +1100 (AEDT)
Received: by mail-yx1-xb12b.google.com with SMTP id 956f58d0204a3-677c9e8ddb2so1542952d50.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 05 Oct 2026 07:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791211742; cv=none;
        d=google.com; s=arc-20260327;
        b=kjVWGIOM6bOVGv2tgNG4ilauC2si3EPyroilORkzNL8eM0HghemWRadBkw1hZlru76
         GypcpnQMkZdUthJIBnpsQCVvSpofG1vCM6CY41XpklTx6LtI5USfIVyK/89BtQBIZlX5
         DczX2u/Qelux1LbqFCSKx7EiqqYlDmz2U2DqK6wRP+Xjr2rnD1z1qdKkHZB0FPs+D9UA
         IYAFhwbitIr03q7JIG9MPCIBOItBfEvsIaSLzejmInTFeaZojvdTxKKFE9YnnaaRUQpl
         s6DSbmXwYt1TH1cZ0N21UIDthRJBJAHEXvP4kJCD1V3Q7iaTeJwBcWrt7BOPQCw4fAk4
         SuHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fB2EelR9jUud/JtAYG8OEIPQSZV00QMO8xof8XIZq/s=;
        fh=cH/F0Cdlfe+VsrCA6lValMNzw5Cygr1XoIgRwbPTYmM=;
        b=o/zYup56b4s6Xa9PZVhrOMJAOY17lKrCRt4byYsESzzI4qDhq17Go3uFxzz7wDExWC
         ucd21ZSBESaNYxEfmKYIldMGYlx5XWfUaF4/jXjsC4lFr8hhZY/AmgPdZqeahLieBGcN
         SE2sAfAYniqgFmg0MuFR3nkUEi8HF4/cD9gWAECuMcUg9EA2maJnCa1+ShIPW+kOu0+T
         YBEPThae2j2NnOmBWRqNH/OdflIplcT5GFVsXvncni8gii6bmNUZ6CQCCZFYhGifbMxR
         K8y0YCr8A1V6UrI9UwHgCGG8Pq+N6eerCJDG88QSHI6dlzvfMYelenpvKM3sox1F7Sa8
         lDHg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791211742; x=1791816542; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fB2EelR9jUud/JtAYG8OEIPQSZV00QMO8xof8XIZq/s=;
        b=CQ1SDXcVdGxtlfZ8KphlCN/cK+bJFk3I33vmkdpEuUZYZKdpPf8XMkJd2gNyNE+aIK
         5PpMXTUcC6nEJfWBAB6jJK4oSrvOY6AIDdKEux3Gc5Zc7gVwLAqrK54KTOY2ylFL+j82
         /Kpi7llzmUe5HvFay0NUfABIz7je0NxnJWOLSSzvzggDrrBrQXBhd2XhuaVbkCJtCbmH
         O5qAslpr7BxnaU43gF0YbHPfyx+w8p0mke3EgcDxYXnXiz09WLrxwfCNxpOkYaflxgIT
         xymiFhkx671NzFBtfkJH1C9oLrKAFURp06g4wPOH5Hesnbj4lPCSCkiAjtDJHioKahrp
         RYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211742; x=1791816542;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fB2EelR9jUud/JtAYG8OEIPQSZV00QMO8xof8XIZq/s=;
        b=jaJq0s+CMML2axeSHDWHfzlW2hy29hOayUVv12pNvKgoF3y8R7HpU0B3noBkx3fQfD
         kkHksR8mQXsp4GQBc0fLmFsv9XYRsErDj7K31yZHpQRvgHFRK3DqbSXRTSjkm63g0jpM
         Zetj2z7tOzbFiEqud3rm8PiamAruBl13R3HGJCcr9ylEEZ2xu4aXlwMsqtijXxYG4Nv6
         CkuloL1Ulpc4Sg+oiIZ2NJESmC1vhxuO8A83+yLp/t5Yicxgq9dzKXjU3oiOuTF/piU3
         TIwvgZ5qpGhsMXXKz/LQ0ah7dU+pOPESk/V7gWgzHD/rfShQWJUOpXKvVOqhXUBpVvfx
         BmHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQoLeyxoM+Utm5XSb5jALfwCtvNPczPUD83tg0mN52yaGN2pISBm5enH8QxAAc/uOiRqfJcFViMYir440=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m/dSQDti3HxiP4c9DYcyNiiPoGyLxGX/0uzY4lPYNxGZO5WO9Z
	3m2NW3NzVMCUjltg4HKohzyTtGq3O+bEanLCR838BzRR0bb6Zti3SEgcoYnxJCM1bCLi+XhjXvt
	KTtL5eM8wpQ8zs4wDtgRU6dp3TiMV9Q8=
X-Gm-Gg: AYBFou1XL7NdELPTApdlHUUB+mrBMoNXAJSFVzHAzXfrKugh06bag3JkaGE2smhBPLH
	fbidQpK9NJPLQmnd8VStNroHLRQJuRpDQZmeZpHLDI4AZy/MiYiFjd0iBYU111sECLt8+jW1dsp
	keMWZdiBMnGHfzNNZF+vcTNA0Thu7AHGt0df9mdjlWPXN7byZb8uSF6ROhQtTudhobnZzZkMAZt
	DlI5HhnwWqFLL757KpxAjeXmdjq0uJcQZuVi1t3wPzrMRzzTsXjgSLNugFA+/3ocIs5GaFWovgn
	k5snMr6xnESTuEIzUZjSPUBMzT96RYL7GnusLhzkgplEnn6r9jNftxd3vhkm6pXtJJuT
X-Received: by 2002:a05:690e:480c:b0:677:b1be:b19e with SMTP id
 956f58d0204a3-677bd373b92mr1921206d50.42.1791211742356; Mon, 05 Oct 2026
 07:49:02 -0700 (PDT)
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
In-Reply-To: <OSQPR06MB7252CC7FC2131D45457A1FA98B962@OSQPR06MB7252.apcprd06.prod.outlook.com>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Mon, 5 Oct 2026 20:18:51 +0530
X-Gm-Features: AclHuK8FXl1Xi-TJ1LO2CDPJEBnrHjPYEMHi6FAYBhWO1gMQvCkpvwAC2mRCkhQ
Message-ID: <CAMFFDGjK8xg=S+f3MyaV+6hQ+6x=g-NQhEAzKMu+X=vdkauq6A@mail.gmail.com>
Subject: Re: [RFC QUESTION] AST2600 GPIOP2/GPIOP3 pass-through with gpiolib ownership
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Billy,
Thank you, that explains the behavior we observed.
The use case is that GPIOP2 is the physical power-button input and
GPIOP3 is the host power-control output. The board normally keeps
THRU1 enabled so the physical button is passed through from P2 to P3.
For a BMC-initiated power operation, the vendor temporarily disables
THRU1, configures GPIOP3 as a normal output, generates the short
active-low pulse, and then restores THRU1. Our OpenBMC tests reproduce
the SCU4BC transition and GPIO123 logical pulse, but the host
power-good signal still does not assert.
Since THRU1 and GPIO123 are mutually exclusive, this cannot be
represented as simultaneous gpiolib ownership. Would the appropriate
upstream model be a dedicated power-sequencing consumer that
temporarily switches the pinmux/routing around the GPIO pulse, while
the GPIO lines remain owned by that consumer?
Regards,
Prasanth

On Mon, Oct 5, 2026 at 8:04=E2=80=AFAM Billy Tsai <billy_tsai@aspeedtech.co=
m> wrote:
>
> Hi Prasanth,
>
> On the AST2600, the THRU1 pass-through and the GPIO123 output share
> the same path and are mutually exclusive, they cannot be active at
> the same time, so having the pass-through pair also controllable
> through gpiolib isn't achievable in hardware. This matches both your
> observations.
>
> Could you help us understand the use case? If the pass-through
> already handles the host power path, why is switching to GPIO control
> needed at all =E2=80=94 rather than simply keeping THRU1 enabled througho=
ut?
>
> Thanks

