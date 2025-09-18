Return-Path: <linux-aspeed+bounces-2272-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD14CAC5A5
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 03:35:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cS1WH5qd0z30Jc;
	Thu, 18 Sep 2025 13:35:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758162105;
	cv=none; b=dwVe4YNRuNS4gQttvQmCqRXAnKo9sjKRQeEcEwv5JXuE+25dHuTiEicMjEYJCB9YiRnNJC4+lCpRAWWI6nQYQRJVamLW2Fuc7u5mM46GT7lEKgDhcLyUBuXQz1u0rO3LGEMoZNM/aZuh/3uBzF/NYS8bMGY9o7XqWS0C1J40qekHL6o20E1kUCAIlw2wzLyKjV4YUIyWEGDmc2bY/1/QK9vEoKOwi656GoOqEkZzJ+7tAE59zgdgfh+bi306u3jiRT0Sa9/McoeNhLDmpaon3htmmGHlnCw7/qbmdueouHULZoNa09yYgSJxdmsuvTy6A1O+zf4dfm2oKZ8ttNOs3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758162105; c=relaxed/relaxed;
	bh=9AP4EHyPiENgOeGo6lnIyAQbYkHufakN6exnZUysaUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPWdKa0DWPoZJOnrjySW1JesbrX0fYj52zzZO374KNvV0CDFuYYKt7sGTLHCyrlJm0246xcBcf7DPF9YMO1t97msN2f+GdGgHdQ63pSbGtvlNY8Oeltl/oxKXc0SRnXtr1cw9VsbRP8Z14u8+Uc+yB2Q8lXUah/lgDl3eHge2N7W1OPHc/S0SeJ9hgAE9cK72dG+P7MxJH1p+gOwP2d8Mn6aMRviwg/4b7l2EQ7rIia6fuSVQR8H3UBC1EGb/zQopw/23lUt1a5LHoJq9fuy38HZp4zJpTxn03zvCuzHRSv/1Cad0hOiPSvzLRAMZ4Gin9ftohkRAeR95mZjJ1f3xA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=M/Mhd3ZL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=M/Mhd3ZL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRzsh4dXkz3000
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Sep 2025 12:21:43 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-77796ad4c13so335675b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Sep 2025 19:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758162101; x=1758766901; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AP4EHyPiENgOeGo6lnIyAQbYkHufakN6exnZUysaUA=;
        b=M/Mhd3ZLD6qsUrZYNCDiz2V3/zclMuvhDEEqufLrmIcqY1dt6eSUtTiWeu0wN1kBQl
         YOQB63BPKj1tg9+KgeVJX9vBEuAPG4T60aqy8KRujsxK7LnIUjI/QL9JzgKbrZW/0uE/
         T4m6nBmpmhkf0m2mNRGYy1zY5Vbait26EzmLlUYRVxgRixEcVDq4BWQ/ZPvnkrQkHnAs
         HjoZ532oy9DziVPDLYdYHY9FiuzJ7b88HBiSbihBg1ESQACwstvLgGq1KNF5tK/22kJx
         /6r477gU7wBvFDTst2xIeWmdAmxv8EU1NPbvlyteiSZOILOWf5PlLCeXRj6F8+MbSkeI
         HSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758162101; x=1758766901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AP4EHyPiENgOeGo6lnIyAQbYkHufakN6exnZUysaUA=;
        b=s2NaSs+m2ysVk7hs0p95p8n7NjdIwJuaPl831g9X9yMYGCZcFBWavQM9Jq5KFRu4UI
         3kERdSdlF7YRQFod8tq8hah1MTXzPFWyVhYe0H/ar6WXsJOshB7HRdJBBH+8hJ/9/W4s
         UYfIDGlm9vV+zSTHDmqHYW4ZGFizZyPV4NxcXCp+snkDmZbQ53ThwKS1iCqxBOI67s5I
         YGxcusysA6I1dFe8p8/hOjt40SrmeFiB3KwmVKOQ6mDkjZUBZYhtv8WoMMpo0BRBfJVA
         Pa5EDiop+d/6i6rUCn7H9X/e9G+TIefTJmzJoEFLUO9Ll1QCjvW2kmZhRPuBJdZl9QxP
         bbzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKDifLjOcfNDDqCjOvTVQyIkytT6/NbuMxddiy1v1KGu2eLihX4IZRWPeRrUirLXaIT09BigyZYPsdjzk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwQKtXkSSdgAPv8k/ejNeTO1rYOqsP3QLeVpKahqd3fwkKL2wL1
	SGvXAB7mC5KRnSxfgrQuWfJmWKtYY8ax17A0Fq8oAm8OXjL/JQgRhY7SqjqzrSV3+kywo1/teLc
	+XgNJk8pXInC7k3AyI8NfQUNhFnOSKoE=
X-Gm-Gg: ASbGncuOfM4Tf90rUB3zzRmoS0M6BYvPk704aqGgKEsM61NLK4joY4vu+usno1KMJMX
	swtgg5VGXV3cX7/TRVodUk84aogADxpzoZQE72oF9YTu2aCJluQLwPktCJ+enBzx9UfcmoVcL63
	HFpIo2k1CZn8VqRYsKQCiP649D34a0lmUfRYTCHaqHam82W6KkXonJMKJ406n0QiwSgzSXyLC1A
	47ulRwW+8/nNF0TV3A8h04cfMA=
X-Google-Smtp-Source: AGHT+IFNb+V//PSot2NdNe8uHywPWrpykUBYjIUlGCyD/yVXRRWQERUfDT3CjUAAlpnDFP1yuGL6Iyf8GhGufhzMKhs=
X-Received: by 2002:a05:6a20:2590:b0:24e:c235:d7ea with SMTP id
 adf61e73a8af0-27aa85b47fcmr6198309637.47.1758162101119; Wed, 17 Sep 2025
 19:21:41 -0700 (PDT)
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
References: <20250917074812.4042797-1-kevin.tung.openbmc@gmail.com> <9bb9929a-8130-48da-983e-2901a7c3da36@lunn.ch>
In-Reply-To: <9bb9929a-8130-48da-983e-2901a7c3da36@lunn.ch>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Thu, 18 Sep 2025 10:21:30 +0800
X-Gm-Features: AS18NWCtilTwOalEuEaTOVX5c4Y78vBcx4wNNE9JzBKwGJPsuMQ80m1HKt2v-vk
Message-ID: <CABh9gBew1=hbJvg1Mhg5dE7Lr_Z442_kbBX6zTs_6_C2NRyLbw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add Meta (Facebook) Yosemite5 BMC (AST2600)
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:12=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Wed, Sep 17, 2025 at 03:48:08PM +0800, Kevin Tung wrote:
> > Summary:
> > Add device tree for the Meta (Facebook) Yosemite5 compute node,
> > based on the AST2600 BMC.
> >
> > The Yosemite5 platform provides monitoring of voltages, power,
> > temperatures, and other critical parameters across the motherboard,
> > CXL board, E1.S expansion board, and NIC components. The BMC also
> > logs relevant events and performs appropriate system actions in
> > response to abnormal conditions.
> >
> > Kevin Tung (2):
> >   dt-bindings: arm: aspeed: add Meta Yosemite5 board
> >   ARM: dts: aspeed: yosemite5: Add Meta Yosemite5 BMC
>
> The threading between your patches are broken? How did you send them?
> git send-email? b4 send?

Yes, the threading is broken. I initially used git send-email, but for
some reason, only the cover letter was sent. I then sent the remaining
dt-bindings and DTS patches separately as a follow-up.
>
>         Andrew

