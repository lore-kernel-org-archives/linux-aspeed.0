Return-Path: <linux-aspeed+bounces-4251-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9522DCD4F2C
	for <linux-aspeed@archiver.kernel.org>; Fri, 12 Jun 2026 08:12:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcC1h09nJz2ykX;
	Fri, 12 Jun 2026 18:12:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::229" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781251975;
	cv=pass; b=oiIeHjmtXIEKkIE7iYaEkIUWcM1t2U9BLXMlJWbWhr161UUvIwc5jlIzDqlgH5+hvOPodNJrrKqWZ4KDx1Gtb5ldbbN1iGttKRc3PKupCrTNqHsiGWNJRF/GjNzOuPE+OqGwi+pfDFU2/3SVhXnYdtaw92y8TNk2DReZW19LKz3SQE6kfvUnIwZQj4rcc9L39i8QuWvSAw+YKt8F+TSN3xE1jS6u6jFXa0h3RqC3Qwxf9BXrx4+IRI+6Rx+Mon9rNb+cq39wzi4eMIN8+FKaMV4hnNSKkS6jpGmY5F9R2OyufLoWhTcXVG7iW26rjBM0aOP/SZG/zJD0kapev8HsEQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781251975; c=relaxed/relaxed;
	bh=6Z3/EAlh42f53h+nvTTSlQbYtPl2Q5o0tMOhx+bW3BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bof4mn4bfEI7swhh3xN96yj4Vw2GGcOCteqin0cBCa7sbLFjB1VJTyPAbQdcVOx17KWHnEkgwBCOUvvPZVNvZ4I77vnnXrZRCjqvctn/q0e8iPmvJsEFkoD0Aw8cUi9QrmUIz6lxeK8Jig4tkgnGvhl3eTym4J7oevrq5BojkRx8wLWFzGAZiDJLT6N998wT1PVLNAZVVxTLT9mpWM1K3Fzv3mF/4FquQjlq8bLHMcVmG8zcggh3AvizJRf/YJ5vOwh+kVL3tEeaQOM4+UTyqZjnGuhAIZNPXhOjZRTBWijigKDtcYJ+yChN1NqdIHk9mi1WWcAjim2pw46Nl5hUbQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LOssWgmz; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::229; helo=mail-lj1-x229.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LOssWgmz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::229; helo=mail-lj1-x229.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcC1f3qZHz2ySC
	for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Jun 2026 18:12:53 +1000 (AEST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-39676ff4674so6369541fa.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Jun 2026 01:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781251970; cv=none;
        d=google.com; s=arc-20240605;
        b=Etu7vJb4A+kw9x+hbXpiAagVs6VVkE1f///gzv4MQi8s1FI8K5WVyA5Dxip5OMpksl
         LkEgDMatcIeaP0AO+W7MMXQt0qYMaOM3voUWIM3zklVdcrHGqK6287uU6GMyCKDx82QV
         q31PgLPXC8Ce8uVHd0OUJDeX1E7MTRdL0suYGU8tpP3U0/lxUTOiBlfN+5OjzRFBa6fc
         8XMkS+peYAtfZOdGtKafxhA+ZJvk6s3M+w7EbUC1/kCZSAlukkC9GFWAKcNkakcFHuvZ
         mfkYfvver800OtkEESJFyUNtz1SxEXaZQ/12pe3kTuaG92cyEDzK/VzbqX4Nsrfeu+QX
         ru+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Z3/EAlh42f53h+nvTTSlQbYtPl2Q5o0tMOhx+bW3BE=;
        fh=+69+NGerHeG2UL+Y016aG0sR+Fdn/Nqet1CpCI4Ae1k=;
        b=ZNYlaVyNxgvt2Ma8HmPZ60vWB2Imgykp4rQWP8bWoJ+V8uaGp1LRHILag1rQ4eYfZi
         Wvg3oddgFilVnaaBlr1Lxg/fRzz1/t0WZ8BDgtTW0bFjiW4hAQHyPUEDh59HGEwqJxBx
         Q0Gi2jRd6dVddOs2qzva3PkAaPKRjXHQ58jH0iKOZ02gW9tkdtYht+bSjWy60bvCQ1iq
         E3GNqMv84Q3LEWy5QGe83BE6H+nL8yNEjD3tEAf1iEHA5fwFxMg313TLqH+od8+v/o5D
         Ac6Hn4jkFLToNphlGwJqXP0UWTCpqMjjAKh3jCPAwcKmuc7JlSYWo3Kg7X8tnz3F33zF
         M/Zw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781251970; x=1781856770; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Z3/EAlh42f53h+nvTTSlQbYtPl2Q5o0tMOhx+bW3BE=;
        b=LOssWgmzi3NZbqXFV1vw8xyb4ihjWsZn6Xm4PLzpp+HG0hzpKflTkWqKxhC+L452zE
         GsY/hiM+DPSwaJe2fp5XqLItsvo6GHypzzSz5nBM2CZSUyJE5ztRzC1SUwoIZ2QlF+xr
         zWY7611D7NhUsZd4zGblfURCJQqNiPdvaInlsbHcTCO5/Ou30Oxmkf7rMqKtjJ1NC1hA
         0TILDgDYzfx4tAmQ3sJWUHGusf2NAevOViM3jbamm2SxwCOO35aGluEyJpzTurTF4sBw
         eJt9MmEwx4RVfcRE5IOchwmA4z5cz0G1ReSim3mwGKRiPuUk/G3T7ooYUKM6jZOKcNOy
         R7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781251970; x=1781856770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Z3/EAlh42f53h+nvTTSlQbYtPl2Q5o0tMOhx+bW3BE=;
        b=cOzcebj6H+ehVZnAtx69zZvWw0hpvabMU7zGwGlE0x4itxmxo6Ms79qUM1iaWZbQfO
         QLRE2lnrFQME/u7GmlVt7xwzoBoDtS1eSkw1seKU/zGEYpdBcWSEldV6Vhvcasj/ESeH
         QD7nl+yFS8iKXgPHFQrziQfN4GxL3GcKBuU9S3TkllQZ5lZQJb5xA9B+e8duXY4I5h3D
         Ho+HO8wJcPhJ1U4tmXB53HlnJJ/VOu5r2RuzhFxZhTy4j+0IdvVWI0cyP2199cvLmx5j
         2vras0uDW7oABuR6yrJ8g5/TXvTFeyx8SSruKzucs2kbK0mQdRLOLF6sfw9cUxIKprZW
         CwIA==
X-Forwarded-Encrypted: i=1; AFNElJ/kNCF/wK9kqBU6fEWfNCy8TzdQMvnOUGf4NsL4eBYl0LpzxildJBmVGs8lYz1x3LrZNJXCGWq+HPSu/CQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyYv+MsIxGhMMGGtcl47iex604eg1Z3Bh7o0rpBEzA7v3HmZ4MC
	hAhoLNiqUn5yvAR0Rqtr3vsvmfJikg2C0XUcoZ4hZI9le4FwOoxMhvqplMvVOGoz67fWKqeua35
	k6Dp+vdAj6ln3DEiOfHGQJuXXHzlm8dM=
X-Gm-Gg: Acq92OH62CYWqJi567KpTmXuYvImOJZftE1/aHnD9thgT+9aFj/JVWSziymdIDeW7HQ
	g9LlLL2qnPLPt3/oUETOU4ku50fW/9FX/UM6BMW3/3ao50KqsfrGT1sDAFNrzFIlSq/T5BLLfZK
	LylWsQNwhY1rS9Qn1BX3l6JI05votsSI8SJ51nNHxi0JW8z0bv5L3rhGWPafz2apGZZiQlJJnak
	2gcchOENaKFXHQdsQkLlhg3TUZogxygLYqsUsKtfQ3jSzzh/yj1eDjgcGjbxUzkKOMPxO8cCzk9
	6XWzVeNOxWjIteWeAOA=
X-Received: by 2002:a05:6512:145c:10b0:5aa:7363:8213 with SMTP id
 2adb3069b0e04-5ad2db76980mr402074e87.37.1781251969978; Fri, 12 Jun 2026
 01:12:49 -0700 (PDT)
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
References: <20260611-ventura2_initial_dts-v7-0-a61d8902bc5f@gmail.com>
 <20260611-ventura2_initial_dts-v7-2-a61d8902bc5f@gmail.com>
 <843dc0ff-a504-4237-b0f4-d92be07e2465@lunn.ch> <CAF7HswOi3fPMFppPoGmh0QELiPz4Po4cyWuDrEHLY2vNMyKE9g@mail.gmail.com>
 <1b10c279-bdb7-4901-aa40-bca36dcec350@lunn.ch>
In-Reply-To: <1b10c279-bdb7-4901-aa40-bca36dcec350@lunn.ch>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Fri, 12 Jun 2026 16:14:20 +0800
X-Gm-Features: AVVi8CfBJjMCk5Qo7cQ6I-oJ5T38DlsPXXzlWiBBeogKNoobN5MIJBGZk76FcJY
Message-ID: <CAF7HswNkfwjYwYLGZXnpg_ruzpzzmz9Cb8FMJpOGRPZ=5hgHOw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 3:04=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > The EEPROM is physically isolated by a hardware I2C multiplexer.
> > By default, the mux connects the EEPROM directly to the Marvell switch
> > for its routine operation and configuration loading. The BMC's I2C bus =
is
> > physically disconnected from the EEPROM during this time.
>
> I think some comments would be good. It was not clear to my how this
> works.
>
>         Andrew
Hi Andrew,

Understood. I will add a detailed comment block explaining this hardware I2=
C
isolation and the out-of-band update mechanism above the EEPROM node in v8.

Thanks for the review!

Best regards,
Kyle Hsieh

