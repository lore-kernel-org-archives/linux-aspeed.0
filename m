Return-Path: <linux-aspeed+bounces-2328-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EBECAC5AC
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Sep 2025 01:00:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cWdn64MvBz2xcG;
	Wed, 24 Sep 2025 11:00:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::834"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758675626;
	cv=none; b=apWJRcUnqTZ/IK+B2SwdvM9hZi+LvXZNhJcEA3e3foOv0Q4n5oTDi3ygPD/uu3mTNbbzbMm3FeMhwQPzUZ4aaCzWrYUMKKJ0k2EWF3TFNdRYWsKFnXMNP2WKqYjDuiysmcWAIJhEVcjj+6SPsoTy2di1TDCSCyNjpCnJ1ahDVuQjlV7FHzRuUByzL5MDX3rEIiC43Y/GsB5s9MzGHRfzFJVy0smtQvwMjahSEzaWMG8UbDDDp+uorQwaMfFTR5Z3vLapkSnQfHNOdYmPFAENbnCGEpT+zYNvWssxD7K602ByTX9/MwOuSaV4Vmr+w6FNg2jkSY/Q0MdCikktpse9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758675626; c=relaxed/relaxed;
	bh=hZsVlg5OxPMiXZWZO+qrLbc/alKsBFgcyv9irh3N5VY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSyqrRU3Q/3DSTGaPXtDCxwbSDV1mG4/xUJedrckNv3ddA97W3cnr35WFaRnowBYK9jyYTeuIb3IRLqvL5Lv4+UPicWWkUsQp3+5KF31TFIzQsUtfCpQrpSXf/k4TpLqYXXZ5bln1fFOAhsQZCgBf8IlLDUG8oJTohLXpUEDoQdPPHX4ECXt4IMUA5jlIB0/sM6MSnnBD2odA6XElaJWnCxhKFdiNOvV+B+FkDGDn/kUqOguBmmANZsBS4dkIuLoAkTulewEAMdGUddA45aXGKyczlOr6IgpdL4SMck7wLUO1ZVDsNHOBYBOdaIPLyx6XRd3xFAGQXj4RNIOCBMVQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JuAUW7ai; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JuAUW7ai;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cWdn451Kbz2xQ1
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Sep 2025 11:00:23 +1000 (AEST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4b38d4de61aso72791041cf.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Sep 2025 18:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758675620; x=1759280420; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZsVlg5OxPMiXZWZO+qrLbc/alKsBFgcyv9irh3N5VY=;
        b=JuAUW7aiH5jwpfbrCWB0tKgplmqG95zh5GbstznBoTiGTn65AQMaaJ5n4AgDTRdKzr
         HOg6oYKS+nA9n1KLFS6gGTgYsMXGbEE1tvIcLt11L5U3jMitUYMXgAAXeapUy2viho6i
         IWGbWDMBRyYvTTmpKC2WRrSfeodZsUcZqMgtqzsTdURflNVp7aysEHdBgc+d/ju5jGE/
         xBFYMq42oEtQX2ajPFF7HhvDXNHiDFtR4lc/g7UPfnjV3Ac04IW2u+gvl6LdLjb+YnnP
         LVFV3zjvt2UCEXyhdXnbKIc/+yjmmnVjv1ktuTCVfBL4JkaAnNYGkCxU+JNVT175TnGp
         gCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758675620; x=1759280420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZsVlg5OxPMiXZWZO+qrLbc/alKsBFgcyv9irh3N5VY=;
        b=poG5bs0IV3JOUJPdjKicje+A7lEXc4qzUnMcj9MeL1bcDfC7km+QX67J7p7KP7bTOP
         2dVA5bZnnSzAGH55eaPomFzmjl/f/97mH3i9zSQAaUHps3XnMcvqkGPUgJV5YRqC6SYg
         GjNsA1CZZA5tAX5Pu5faZhiirbhfV9Jly1yewOgS2t1uhiyNWmyrSjrdam1YhbRlj20E
         nrNJMsWEm0/cahBfaBF0TganHMcFwSUoLQxvg2UG/uk/NgaLSBAqTl4GJt2hadVD18eL
         e8xetYPeem28eNEUDP25WokgPadXECzK66NKrhtZkLL0CebAbfQJFO2xNC13nnsTbCko
         eeCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/zN5NxYoCz53D+Ow01Wpm9bK/F1+DNERu+9ntXv5rgZk4jVI1JFMrRLBMIGr3rod7XpvRI7LFAG3royA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz+SvC0hNZgX5GUsgkr1WIO5wC4kJzy6ioiMgM33zG+AVOKQ766
	UoxA226DX4VKSvJpZVhGxniqXAyUfl6U8WU4KWZQJO6Uaevpyo04oszqGmCE7XvtHSa67qAwYlJ
	wWNK/C3nPvTM5Yab0N5L1nrrvIDnU7rU=
X-Gm-Gg: ASbGnctgJGxqYMzJv+5RrHOWDCoiHTreVeXJj+UMYN3aMmxuHoN3vz24/TSClvUPoa5
	pmzPZb5CEOPWbjjVMVN6haTbOGgQO2D6ZtshnCeHqR8oT7sk9znL5kzsI+7L5CwXZbsGOiFZYxT
	pWw9lPGPlOy/uFq3aJM1iMPFY6PaFg0JRHlq5H6L4/qPF1BEQYCPpukts5MTVC7WySJbxt3luht
	KkNQQFNLI4LjKfhO7eBQkANMLClt9R1vrroTDN0aA==
X-Google-Smtp-Source: AGHT+IFU+HdxW/LEWFydKq5uIjzjnXTJNktogq3srwO5gahMvnvKX0l6y5Tq5+EvCdygt2yb/FL6Q+goFczk6oDSGcI=
X-Received: by 2002:a05:622a:1905:b0:4d8:67fb:4180 with SMTP id
 d75a77b69052e-4d867fb4421mr7701411cf.8.1758675620385; Tue, 23 Sep 2025
 18:00:20 -0700 (PDT)
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
References: <20250917101828.2589069-1-peteryin.openbmc@gmail.com> <393411916e94245a9f3628c41ebee34c3dd95a98.camel@codeconstruct.com.au>
In-Reply-To: <393411916e94245a9f3628c41ebee34c3dd95a98.camel@codeconstruct.com.au>
From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Wed, 24 Sep 2025 09:00:08 +0800
X-Gm-Features: AS18NWCngewRu6_z1rC1usvMWn-hg2wKnEFU7JU8elKMaPgAwRFUKF7tF2eGoqo
Message-ID: <CAPSyxFQ1O-trBv9AQAn8nrh47zVAX9GLFovbpcy=_5Va6rDUcg@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Revise Meta(Facebook) Harma BMC(AST2600)
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Jeffery <andrew@codeconstruct.com.au> =E6=96=BC 2025=E5=B9=B49=E6=9C=
=8822=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:31=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi Peter,
>
> On Wed, 2025-09-17 at 18:18 +0800, Peter Yin wrote:
> > Summary:
> > Revise linux device tree entry related to Meta(Facebook) Harma
> > specific devices connected to BMC(AST2600) SoC.
> >
> > follow-up:
> > https://lore.kernel.org/all/3a65d568540e9ca43d3bfc24cfe5f72d2bb12b3b.ca=
mel@codeconstruct.com.au/
> >
> > v1
> >   - Patch 0001 - add new line between the child nodes
> >   - Patch 0002 - use power-monitor instead of power-sensor
> >   - Patch 0003 - dd sq52206 power monitor device
> >   - Patch 0004 - dd retimer sgpio
> >
> > Base: tags/v6.17-rc3-39-g07d9df80082b
>
> Can you please rebase this on the aspeed/arm/dt branch of
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git
>
> Patch 2/4 fails to apply.
>
> Cheers,
>
> Andrew

I will fix it in the next version.

