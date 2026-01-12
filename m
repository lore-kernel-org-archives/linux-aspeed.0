Return-Path: <linux-aspeed+bounces-3295-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAF4CF45D4
	for <linux-aspeed@archiver.kernel.org>; Mon, 12 Jan 2026 22:41:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqnRD6c49z2yFK;
	Tue, 13 Jan 2026 09:41:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768252993;
	cv=none; b=Xd1gH4wfWktxJhmPFqmtUWHnUd77/higcU45/Ihzgg8vSDrgGHYn9cUWZewsfTDrMjKvxwJEOUP9LP6C63lW7vBv9TrD/A5QaIeWmzyZuhK6PGChqkPLP1uqONfcKdtGYFNKaxYda4PH1qIGfguYO1HykRj3hdFqC0mzwlmK1rRk67KoABvCE0d6kzlBB9yxySLKxPerskWP/Kz6Y5UR0X/cwUBSBpHqsg8SNp/NouAfV0jfMnaLu68lezfuWTGncuI0FwwndORNloQgxE4xDmE3c2qE7SSdnFivm6Us3m4/nAkaiJWNV4UhMujVnwfgE8pz/O3c6xMzsu9u95L6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768252993; c=relaxed/relaxed;
	bh=9TZYdcy92buA5+zb8K4DSLhDN3VCy/dmlapRWN0t8u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUmZBvwArGLMKLw7jys4+xOH98xGiLL++Ha5VB9u5xtypHst2LhJAiJSSJ1wIlJcBY+90h0EVVFtGSCACPtWAIy2tmosmd5p//LWgQMWrQQWm3Fe8ovhWL10UCOtWI/zs7gA4+YzGwRqcReHMETk5gsD7tj/lXARYLqCh+BFUvWv3BOIyH5fVtFZz63s+vOpwmp/aixU8RbPePBR5N/RgHxBC9K9MjiceqSnteE8G6UjFVhEdqaUFnyhCa1jKoAIW6D0uWVnymEq2KmcCD24dqDLCDu8rAuepEHBdY86E8kQeYBsAMam3gl8C6J9fzewfRgAs3t8+6joYecGt8dMMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TX9GjQBA; dkim-atps=neutral; spf=pass (client-ip=74.125.82.53; helo=mail-dl1-f53.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TX9GjQBA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.82.53; helo=mail-dl1-f53.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqljD5XDkz2xKx
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Jan 2026 08:23:11 +1100 (AEDT)
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-11f36012fb2so8977873c88.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Jan 2026 13:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768252928; x=1768857728; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TZYdcy92buA5+zb8K4DSLhDN3VCy/dmlapRWN0t8u8=;
        b=TX9GjQBA9vh4JTtuX3MVwpwYgO6IF9u54WAtERpD5CbK/6qJsqJrVnHrLSt8gvD3iV
         d1Abd6NEwLhqXd26Ih7utmd8xtsAFsiwRJVm892VuB99k75Q+0nvQdegiQicZ8u1F9h2
         54VBSZJwYEk4F3tnNnCWKJ/XHUNn00ibZnkRBJTA3Fo8qvZZjp1meUZDhRAEQjAjXwr8
         Bab5f716ZasSxtUJfBnjXbKbbo4O/bI9TCJpDKeRBZsiuHu39gi2Nfh56psxcaFFv1Gl
         4L7qn2s3waz4tDMAq16qawyz0TUqVstyenubJq2NJZuiADLmmccgMkHoQTnuXuKv1wrL
         ezTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768252928; x=1768857728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9TZYdcy92buA5+zb8K4DSLhDN3VCy/dmlapRWN0t8u8=;
        b=QUIvUok0C2sOp8HKYR3I5EkSH9nNrg2CdrxHCW9VncBdGRkETSEJBQmIDZonhANoGO
         0b84lFtDVxtftajYT11Votcd+rJYABcg8v7f1saQE5b2n1yXmBggFY0azR4ewCPEkaNZ
         gqBnBs3IhLkjpGgaDtyEm4Sfkf85y6/lKa+tx5NTqGNLw3RZ9uM4XUoQTyyyQWPrEtcO
         wbmuFjpAmeNp5/htqaBJLBmIf+55FaZQnQtYCqL05m7s4C98RPC/1i6i3vJtqPfM6Uzj
         QIaf71BDILq2WecvQydxtQYLMvSzdghKaC1sleBIJLdQuReFWbQwyh3IT+oakgMs4mpn
         RN4A==
X-Forwarded-Encrypted: i=1; AJvYcCV4vdHi1YPMZj5FAu0fNaPn3X8o4q8XVnP53ojHkvMDbjFYV6Haho8DGEcBRv8PvUpui/8Krx4KoEIizz0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyFG1kNJPMPcCY52aCokhBNatNPn7W5kGHfzk7wW/n2nN7rgYsF
	o+m0LJ8aA7Fqv6r1IejeHO5t220elf9WnC5dieMdNE87VYE9N2KcHfDuH1p3e3yNf8iyAUm5JvM
	XIWa/mL3JT7NHUEjkiEU7/CGhKFYd5UU=
X-Gm-Gg: AY/fxX6nU2unBywb8y5NWlSn+rkOmiGziJ0xpJAAKoDhrgn2kskLAkN4ZGRv8Oqwady
	LxL5x1I80p19zb914d5UXB8rNtenpF3BHyOvU6nYHnrPvERB8wJtkJReMP+yIW5BsPQESbXR0A+
	Lsk2BrSLiLkkk3gCJ7dqS4maB0VW47du7lPQ+gQkrpbUEdyFGB0wG2+y1Rj2G3UKbfgy7ovJoJQ
	KSNL7SBUa5TMFrpi/UQbZb4Tk1aBsNQVPzciobgrysXLRg4+Sk1oGqtO5KVczQ7lslQyAf8rR2S
	AgS7I9aA
X-Google-Smtp-Source: AGHT+IGnz+TQ1FzkSNkzmiP6ZsSsl7BSHvN2O5m/ZEyz5sL8MgaN1tiwfu3haADXH57oieB3BqIDHqdJD5bVWVx+bZc=
X-Received: by 2002:a05:7022:1e15:b0:119:e56b:91e9 with SMTP id
 a92af1059eb24-121f8b46102mr11509935c88.26.1768252928474; Mon, 12 Jan 2026
 13:22:08 -0800 (PST)
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
References: <20260111201040.162880-1-anirudhsriniv@gmail.com>
 <20260111201040.162880-2-anirudhsriniv@gmail.com> <45bdf2a6c0d33dd6ce0fd3cc279ef6edc509a540.camel@codeconstruct.com.au>
 <20260112-whimsical-annoying-fulmar-25e4d9@quoll>
In-Reply-To: <20260112-whimsical-annoying-fulmar-25e4d9@quoll>
From: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Date: Mon, 12 Jan 2026 15:21:56 -0600
X-Gm-Features: AZwV_QiDoxEQSz_VBTL5mNLDJkArkIs_IZ-EllE4kfBgjkmOnTgx6aTvsjJIjLo
Message-ID: <CAJ13v3RKydFK+sP_Cm-HnQjsOJSDyX_dsGs_Yy564V=Wc7tQFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: Add Asus IPMI card
To: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Mon, Jan 12, 2026 at 5:47=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> >
> > It's a bit bike-sheddy, however: the pattern tends to be
> > ${vendor},${platform}-bmc, but as the platform can't be specified and
> > the card's function is the BMC itself, I'd go with "asus,ipmi-
> > expansion-card" (I couldn't immediately find a useful identifier other
> > than the product name).
>
> This should include some model name or at least soc. What if you have
> IPMI card for ast2600 and later completely different for ast2700?

Personally, I was okay with Andrew's suggestion of naming it
"asus,ipmi-expansion-card" because that's the official product name
and that exact term works well for online searches.

This seems like a pretty niche product Asus announced 4 years ago and
made in very low volumes. I'm not sure if they'll make a new one with
an ast2700, given how the modern trend is to have BMCs on
motherboards. What do you think about the naming Andrew?

--=20
Regards
Anirudh Srinivasan

