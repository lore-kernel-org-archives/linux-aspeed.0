Return-Path: <linux-aspeed+bounces-4080-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBC3CD4F4A
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 23:52:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKF2N6rjTz2yDs;
	Tue, 19 May 2026 09:51:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b12d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779106936;
	cv=pass; b=WMKG03yv7LihuwvtD6Dcjm7ZNGhN/k9F4Jt0BccA5yTH3Jti94ncElGywGYDJhO/T+q4GWViUHXC2wH3nv07sCt1YdHYCGytF5ncnKt8jz6Zq7Ls3HsONY9mn+G46XsAa/KX/BUjtcL08zp5HcJ9hV9L3wUFO5T4RHts8p3RmdqqNVz+Z2azVZuAGLXsOYQUFAoNl+rGUa43ByGK/r1l3LB+ThwZxHAXKbiBxInLAGmCIhJV7y2Y03mpkSmjG9VEkW+Le4qgWfS/8KJCzwTdwtcfz0yYZzS4cHf33S7u8tNSR1pApHBAaRjFws6nzn3S/9uZGqU6EFfSztW+/O7N3Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779106936; c=relaxed/relaxed;
	bh=0DmqL2TQVuOZcJ1kwkK1W1HCSHqFXIeI0h+ahK0Xebw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+9MhoSqe1LMX5ar8YSNH/IonvhC1eZshxvXBhudt7kT2Yt/Wb07Unw5qf01DmziAOGpt6iOpyrNFaiV6NbkL0pi+PoH3myk9qvK3Ybbn/SnB2aI3tsLn8tPUM/bzQ1IHnDpAJXPo0GfF+9hsgPfTp0ADjx7l6A4bOu/Sq6aAIQ2JU6iX/ZIIFBiAJyPQh4EzU3pMeH2x2bQkyVq8EheMteH5T0Xw343fkcgmj6zZ1ftJb6p30xKanz8GllahIJcONXLc5oNlofCo9p347TSJIEy6kWe2zaxwMa26aU4OPO6skovFvw+CwPbfFqAMpF9HB/lGPJqMOAnulMUG6/DsA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BH93Ij7M; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12d; helo=mail-yx1-xb12d.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BH93Ij7M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12d; helo=mail-yx1-xb12d.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com [IPv6:2607:f8b0:4864:20::b12d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJxkt61ftz2xPb
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 22:22:14 +1000 (AEST)
Received: by mail-yx1-xb12d.google.com with SMTP id 956f58d0204a3-65c364b893aso2446971d50.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 05:22:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779106932; cv=none;
        d=google.com; s=arc-20240605;
        b=HjlljLCO6RWUYRRnPO9vLIAAljkFkgJu1Mm3q053KXRtEDE/f+X6aX4VIWYLUsORjo
         VKXVXcOmWhSZ/ut4IuqosjFoiCl+LY29aEHcmT2b+yMcIFs1a+E5xER6UQ8qi5ZPYJes
         A0cwM7wNWz1rw62HVF8d7+o12wqeDSKYECy47MyA8I91leXhkIGmnXbbp//KZfoIqI16
         WLgWbwgMVprgJRClNgr/yvLAZZk7qAiSxVBRty3nbMVwCWLvU9KtRlenNq0DPQzpGF9f
         zReEmz31J9zB8L73yHjewsZmdEXZz8Q27INKCsNAN+twAVwM8cn49qdiuXJq10zV8SMm
         Rjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0DmqL2TQVuOZcJ1kwkK1W1HCSHqFXIeI0h+ahK0Xebw=;
        fh=RqJA+IUDqzzdb9njS1W0nfE+wdTB0j5Vz6YT5wXz3QA=;
        b=HlEjONVa9JcNzugNu4qkJjmu3QSNd8h5VMGWMWuorAeWATcFNTbAyB5fW//ZLeWhh2
         8G2U6WU7bDP6LGtfXu1ICQAN1opdYR9Lq7GTRqP9wLJPcfYY51G57imsZGRBd6906HNr
         seXdb5lEfDm1yZuybVVl/Qnu4kTJil3H9oOX1umBuvx7edqE4iVenJSwCpKQ5z+BQqkn
         sBlvh1qQtOeXu1/cxWd4qEpM0/2at99K78C1pNFmufsvo8OYoe/NwtYrH+bfbpRq37vi
         H47Lbw0tIL0FQXzozLqk94S1whXBXV8xfM5eHffPIHmqkEY27oHVEagzrGlUoZHkA+xS
         ofGg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779106932; x=1779711732; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0DmqL2TQVuOZcJ1kwkK1W1HCSHqFXIeI0h+ahK0Xebw=;
        b=BH93Ij7MA92dFvZSTWeHKLZ73OxPuDvKa5mu/MZNTbB03cw1mdl9O9pEhNTQoUU3Du
         u3h2gyggrvfBmKXgxf586+tBI1sHGvh1t7n2976mogYrRUgWNlEehoJ87GORJ906Ex3b
         rcUDUpkqgVTb2s+WFe3e3jSYVkJxNS4ugG+L+kqBRb51pZGMz90pAxDuW3VjFN5xVoYs
         EtiCtBwnkxbNlGAzJfgGeyHZ4TrgCA4VdutUEsHYzKgSiVi6yCuK4SgbU09KL14w/L8q
         KSZ5t5aMfbIn841UkPlbofBCsOnINKAe7xHs8FyZicFigH7XkF90bXDncILa2an1YwUy
         1OmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779106932; x=1779711732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DmqL2TQVuOZcJ1kwkK1W1HCSHqFXIeI0h+ahK0Xebw=;
        b=N5yv+2myFv46pKnGacaOqgJbo3oU6nIXB30eEmY4IlAbaKeoj5WaVX6duutf40nb/6
         xzWG/xAPPsgWUp87wCYCHOel9ahxcZ6YLoBJnul+Dy9Sc0lPtJ0+wprh/K8KQ5FJg5uz
         ReoAuzcgnMb2UuNF2GH0tRR0JLlwt04VbFcxdF/nB9zWA0QfmTjFvfOpb7VqLNH0NVwQ
         dDzj09DC90urrQ+bWPd1X8livxJdIWP7MvucdGQEHlc9qCBqRhaJbOPzo4B6brdxPy5q
         DMvNqpdLWIPkrqX48lsWTK/vYj35MlsLoVrMfG7D64EdF9jcIxCf1b+YKoG40hzMziPg
         TUgw==
X-Forwarded-Encrypted: i=1; AFNElJ8z3ghna8mpp3AFoUe1wLCWABg27PnGfCuqwOwAd5TRkSIEzNXtf3uGLO2dTPhy74UCDIKdV320ROcYjnM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxfnaRX1uPdVlRXRp25uxjbARPqvtEsUMwPJ0Le6SenRklsouZ9
	1Ef+HaumQcgGcuM7F7tHuS0yrVTnrevacKOmeGhkpQoPbAawOzx9qYcIxAfYpVFNL87GcGq7ED8
	bWiwDxIOLLHq1zeE6gFE5NIyPloNVnoM=
X-Gm-Gg: Acq92OGKLJzjBWHhlaxVJaju+MgYO1Skd7wVlQ8Zr4/tAXnlKw1JmWO6Ap/kFp9pBBj
	6MGSys1T6KT7/K1+omxzhgf0C3bMIkFiwDq72x1mKCq9BHry4FJHA2hBgXzIKb7BhL5928oMSSc
	nhb579nAod2qK9or/bTE3MH5ziDnGUpGhWbMHEIQ20E/bgCVP/L/QHj7c0g3A0BNgkOYoMqIR9m
	TxjQs/mbgUMASbJBZWPFgCCouJAdpQGrODCp3GUTej0v+89nILbIqTFyY4AyB+oIQ3DyGLbpFfE
	yfIKSXd+ESt3j393Xr8RxKGZCMfTGqJSaxkZ7Q==
X-Received: by 2002:a05:690e:dcc:b0:65e:5110:a5f5 with SMTP id
 956f58d0204a3-65e5110b155mr4322130d50.46.1779106931632; Mon, 18 May 2026
 05:22:11 -0700 (PDT)
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
References: <20260518033440.17569-1-prasanth.padarthi10@gmail.com>
 <20260518033440.17569-3-prasanth.padarthi10@gmail.com> <ddb781dd-e117-4f9a-a5a3-94c192d8c2ef@lunn.ch>
In-Reply-To: <ddb781dd-e117-4f9a-a5a3-94c192d8c2ef@lunn.ch>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Mon, 18 May 2026 17:52:00 +0530
X-Gm-Features: AVHnY4JUIzHBk39gdk-SpRlXAlvxsl6WnlY4f4t2rw7kIZsY5dCEGTha53-U1nk
Message-ID: <CAMFFDGg++xLX+DzTnKVZRdbs=_3SrNfDydezRQgRjCBU5R3-KQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
To: Andrew Lunn <andrew@lunn.ch>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch, 
	devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: multipart/alternative; boundary="000000000000ad6d320652169ca0"

--000000000000ad6d320652169ca0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Understood. I will not rely only on the vendor DTB value for this.

For the next revision, I will drop rgmii-rxid and use the conservative rgmi=
i
setting unless I can provide board-level evidence that the required RGMII
delay is added by the PCB/PHY configuration.

I am arranging hardware validation for this board, and I will update the
Ethernet node only with evidence from the board/manual/logs.

Thanks,
Prasanth

On Mon, 18 May, 2026, 5:42=E2=80=AFpm Andrew Lunn, <andrew@lunn.ch> wrote:

> > +&mac0 {
> > +     status =3D "okay";
> > +     phy-mode =3D "rgmii-rxid";
>
> It does not matter if this is what the vendor does, it is still wrong,
> unless you can show the PCB is adding the delay.
>
>    Andrew
>

--000000000000ad6d320652169ca0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><p>Hi Andrew,</p><p>Understood. I will not rely only on t=
he vendor DTB value for this.</p><p>For the next revision, I will drop <cod=
e dir=3D"ltr">rgmii-rxid</code> and use the conservative <code dir=3D"ltr">=
rgmii</code> setting unless I can provide board-level evidence that the req=
uired RGMII delay is added by the PCB/PHY configuration.</p><p>I am arrangi=
ng hardware validation for this board, and I will update the Ethernet node =
only with evidence from the board/manual/logs.</p><p>Thanks,<br>Prasanth</p=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>On Mon, 18 May, 2026, 5:42=E2=80=AFpm Andrew Lunn, &lt;<a href=3D"mailto:a=
ndrew@lunn.ch" target=3D"_blank" rel=3D"noreferrer">andrew@lunn.ch</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">&gt; +&amp;mac0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D &quot;okay&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0phy-mode =3D &quot;rgmii-rxid&quot;;<br>
<br>
It does not matter if this is what the vendor does, it is still wrong,<br>
unless you can show the PCB is adding the delay.<br>
<br>
=C2=A0 =C2=A0Andrew<br>
</blockquote></div>

--000000000000ad6d320652169ca0--

