Return-Path: <linux-aspeed+bounces-3229-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340DCD3B7E5
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Dec 2025 01:51:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dffMv6L7Pz2yFq;
	Mon, 29 Dec 2025 12:51:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766454618;
	cv=none; b=lWutOfBcci4lEH5AoMCAuar0MYTKBvsn2TYessE1cIrsu0a0FmqhuwpEl3wNk74AKU4vb589zXjM1zeaHG231q3D6qGGLWqfT2WOhVSArQTihztlG7aTlMkZnhlXuM3uY206f6VaXEtSeVbL/rgMr/mSpCItwr/b7OlWqVlOBs7RBsoYHs6aLy7bG4pRFmiauuU8p1sE5Ea9UJ/Q1o+QcqxP491cCDYpMtlXMb06rYYvqm2XUeqi5Ud1hUxsWuZM3QtYbSXGDOaRmnvfrYQjDqsrT7voz0mp9jXx1GJFoXqH0Dy5Dz42AQ8lSoG+sPXmwnpcJSA6lLNKKQtwPPziTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766454618; c=relaxed/relaxed;
	bh=YF2+2OBqACOiCo6iSElhd5mEow7KLbkSPjlb63HoSsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6q5r9rTl46AxouCDnil4SONEt82mVJGea0qHmFvzirX4yovc5tzYAIcObwVjVAk6jYbgFDJEebrqSqZ+fk1oTvqLOLqxKhQ242sK9PyXLcKERGiMDlb1gE4OleUOGhxTnMb/kvW4BUav6ZnUGjcZ1XrI4f3Ha+w0MHXZoCDsWVTK0j/iiab25ctE5xaIws8VJrYs/68mRhQgyiQAbDlyTw4ZopsX8/1vVMdi5kJAc+v6/CJsWjLxeVwPMmIp45oqDuRMNuzdDDa9Qg0BaT33O3afaiZSRiLbh5KorSkY6FtyxAzVWt6X06SSe5uEQH8ffGZsqNIWSrNP0gkF+FyjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=J4GTagT0; dkim-atps=neutral; spf=pass (client-ip=209.85.221.174; helo=mail-vk1-f174.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=J4GTagT0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.174; helo=mail-vk1-f174.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZyd51PGzz2xdY
	for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Dec 2025 12:50:16 +1100 (AEDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-55fe7eb1ad1so3420089e0c.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Dec 2025 17:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766454553; x=1767059353; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YF2+2OBqACOiCo6iSElhd5mEow7KLbkSPjlb63HoSsQ=;
        b=J4GTagT0uWnm/j+zm+frZaAvRlTVOHpq5a/GDh491+nqs1KCsfeDFd3uDGOHDNCZ6w
         s7O/JbhEAOZy7pkilFPKDnx8klHAN9sXhuf4jZokj8dkDj+UJjKYBoEuBAZ5CenouN36
         cOF4YgumPZpv6XyVUufN0e2kZkdqVjKIBXuby1vsYS7gR5ikX4bDs5c8rw20r4bqV/jQ
         ZTLEV/QQFVcy4W9xSIU95jpOXEAsf6ueJN13R3CYuYToy1NaNAWwKuOfuXQoQuaPc9gP
         stmgKEqomp2Erkh992QTvz9sFCleUn5YGp3ZOWdPR0zBtipMOvGtMNaS8URtyLlC2Mvl
         V18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766454553; x=1767059353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YF2+2OBqACOiCo6iSElhd5mEow7KLbkSPjlb63HoSsQ=;
        b=mA6/2OXWF36s1CbmUHLiUe8AJ155baEK7+dGWBHSSYg6Y9ojXCCu8QPQ0ETZfM0XFB
         Ju38WmwhTAiQTN4grw4wHz8WCf3JZIz04sRqOLnmK6Pkpo4A/M8rUSg+T6C9OxNo+iPT
         IjXd33EGj6IJfuQiAy4VOEPR4Jk5yro7o3GQOwGxs6j+OcmsNaw/xMmT70x6oydao683
         mVlgx8ZsiusLrOpevgDtFrgtGGZe70YLeK8oFfav685puS8Dnwf4gbcsXS6feD+iBJtF
         B8s+BCn9Sm0Vnane8UAlyxjyiyFLZSLPx+VmufdPQ8594e7yYxE8YWaRw99V1LX26JeR
         GW/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtrAWwcSCyxAJt/hbKeQidgSub+pAWVQbbd6vkPMWQCGJCrDRpdSNlAd87ldE5+4atZZbk+RESfuKAz+w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyJE8MrNXpdfPnsLCpeSnpn2woaiTxwgGD9Aha7YEWBnv1SYAJr
	KS7pFxhB9VGMXnslPqmx1E7LXzb9Qsy8/x8wdEkHYlO296qasFVlc3hJWDHW8vKnV3J3JdmyG2B
	R4lQc4ueggXF9gZRidnwTH+HiSi2nqBY=
X-Gm-Gg: AY/fxX4rh7y6Md1eG2hSIGoTaK0oA4pkdCvzPutOWLJ97BhJJiUlyEouTSiezZ8vUX8
	uL5O3K7xdHSCMqnc5gouig9TNIxWJxPzPrW/WC2GC2zYamF/0w8qHLZyqdC5bWLHgkkzUgLrayX
	mM2qUp7hTfxTXQ9LRV3CgLkdUWDFKP6dhQcCNh6JHABvyZDaS+8LTgicB4oRvUJGQNu9oJuPkBg
	j7ETm3NEHVZl4Cq/4ZZe6+Ja59SZjTL8sBkOcU022o9bjXkpe5D0xzqJTraCsPBRoaZNn6c
X-Google-Smtp-Source: AGHT+IHBHq5niwB64zOQi9Ir1RYdcuhYIiAiMknQ60wGRGAecKNEstEn4F6joAjyRSSk+aJXifaYWR8qfB82RD9k+ME=
X-Received: by 2002:a05:6122:318f:b0:559:83be:69c5 with SMTP id
 71dfb90a1353d-5615be07d05mr3706682e0c.10.1766454553289; Mon, 22 Dec 2025
 17:49:13 -0800 (PST)
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
References: <20251222-ventura2_initial_dts-v1-0-1f06166c78a3@gmail.com>
 <20251222-ventura2_initial_dts-v1-2-1f06166c78a3@gmail.com> <c069b452-df22-4afa-bf6a-c48949f40ebc@lunn.ch>
In-Reply-To: <c069b452-df22-4afa-bf6a-c48949f40ebc@lunn.ch>
From: =?UTF-8?B?6Kyd5pS/5ZCJ?= <kylehsieh1995@gmail.com>
Date: Tue, 23 Dec 2025 09:49:02 +0800
X-Gm-Features: AQt7F2p2os6FavK-DkfJbJKZMaXhN9nltNSiU8Gza--K1TKLdY1MJx6HBIjggPA
Message-ID: <CAF7HswN_jEXOU_9K4LpLnbhvd+RD0qqELAHxMBbp=hGtMjS4kQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 5:30=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +&mdio0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&mac2 {
> > +     status =3D "okay";
> > +     phy-mode =3D "rmii";
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_rmii3_default>;
> > +     fixed-link {
> > +             speed =3D <100>;
> > +             full-duplex;
> > +     };
> > +};
>
> That is an odd combination. You enable the MDIO bus, but don't have
> any PHYs on it, no phandles pointing to it. And you have this
> fixed-link. It makes me think you have an Ethernet switch on the bus,
> and this connects to it?
Thanks for the clarification.
Yes, there is an Ethernet switch in the design.
The MAC is connected to the switch via RMII using a fixed-link
configuration.
However, the MDIO bus is not connected to the switch and is not
used on this board. Enabling the MDIO controller in the DTS was
a mistake on my side.
I will fix this in the next revision by disabling the unused MDIO
node, while keeping the fixed-link RMII connection to the switch.
>
>     Andrew

