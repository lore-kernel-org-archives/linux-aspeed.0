Return-Path: <linux-aspeed+bounces-4083-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB32CD343F
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 23:52:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKF2R0G6gz3brV;
	Tue, 19 May 2026 09:51:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::e2a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779101010;
	cv=pass; b=UnDHvbZMORJ4jP9R8+U5MTDHxT01XqJEp+zzcwPjavTzRpz3xYMqh7VVWuu04U4jsg3UcXoNhBbXymVfPqcviy2NeKmIlE4T8t5Jomxc+P/itXN51NAqE48gT1cIpQQktdBFZuPWbffOFwQARTh4Y5gg+J2VBCxpCk8G7uxNtOYp2CrZ6S+3r92mvYtQZVNTVmcOpS9CRgTrVZeE7+WtBun8JtSuN4jYBsH53c5SKNb1CeWKRTY5ZwolFCVSyrqJdrAqSoq60e6pHhG5p6DrFca1Y0YdSZ2tm3PxRLPa3YiyDfznJgpI6VAzCAdQGVyRKgSjL7+6Q2eX0zer4YIh9Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779101010; c=relaxed/relaxed;
	bh=xTs49byiOKMbFqwJ3wm4pcmStKZPG6RE7CVuUJdE960=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMbFMV3f6XCXIpQKyxyoMyWGlgMhWT5kcEMNIq03NMObFFHlpNJb9kEsqD2Tj0juguePRZuOUatkCqrn5OrRcjYohvNRpwxEkb8+QMouuW8u29BDqL7rEW/IbotVFci7D+I0UG4Dcd6ppYlq30up1vG+jkGnloHBSh0zF3gM22HeIP5HDlpGOVaMtmN57L/cNBqvInbpzLT7LHDVniD+Oty41O94jYeZC6vVtFnQ4iLno5BSblN06nfWlUA3a8ep6IWMFl1pBV/qncqBsIMKXZLMrsQXlikijMtLqwkfS6Q+Fk9gu+YNkJAFAEP7egsGNTTlD7UnxkW1Uwv/7ifC4A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hlSigcKA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e2a; helo=mail-vs1-xe2a.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hlSigcKA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e2a; helo=mail-vs1-xe2a.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJvXx2zhvz2xPb
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 20:43:28 +1000 (AEST)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-6313c800372so1685801137.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 03:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779101005; cv=none;
        d=google.com; s=arc-20240605;
        b=h0+f85tUNaILYHQCyytx1mdJEV+CBZvyS9hSSiq2pf/fEbFLu34JB6zDXzs5JiZC+q
         P+K5etPul+/pY+Ks7XLKOoK6m2ABtvFHXs3YJQA0ewcuXSH1hLV86utrAjrGOpTDhk/A
         6oocd5bmzM3j85M8zhCIRTdLCFF8HrbIzeeGI37XQezhVhlgggNqOL1+A4Q8PdO9ksJv
         fILDCrMVmlaEo7pgA2+fJhBp658r4cHNMjjeV1BRl+ciqpmilFALMRv4MB3JXxFUhrIP
         MTltiHGC1INEkWMmLJrd0BnvKd7QJZBWoDKoBvUmZLn7aCAdI293uqz210GXBZx1JHtY
         cRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xTs49byiOKMbFqwJ3wm4pcmStKZPG6RE7CVuUJdE960=;
        fh=lkoWuaIdSV98MkNIvb4Gv42BsnhxM2zAFyP9zdmjUns=;
        b=ablfCdqo61MQ8TKJO/O9Axx/0M/puBSRtM5nh42HClx6qK/6gscZ+/x+QQqSxa+aHn
         kxo4ZdZJRlJtPsz+HpNd+61jmg9NRaBezyZOFDRNgrXxNOB730jFVQvpOPZtN7R8IzMt
         zq4Zoa4kx0Iba4uFyTC2PIMx6xwYsdzNxVwdI8UOffxjWzpEQUDsXtJxODsJqG8DrAxs
         Ck4dDzwjXlRzLfXD8QUszcDV7qyRFiKVw6umN41qMlh4PcRSwfwGFJ2xJNt4oF1ttcDu
         Ifgn5LMdf3TGb/on66Zy8HXpztFnY6dxkxX8HXPSEiHeDm1NaBVEN7qxi5Jz2Fyigcqy
         9GlA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779101005; x=1779705805; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTs49byiOKMbFqwJ3wm4pcmStKZPG6RE7CVuUJdE960=;
        b=hlSigcKA4l+FYEAkZWJEsiyCEU8PZq6tJKJnA9x3c9c6sCFxD8apO2Sxuk9KzERsdh
         KguYmRQuB/QzFyxeP1fhJJ3lwLz1Bi5O4ZQTLNJzvj2RoSJSyUkvQRgvNwdqEUZ2OdcV
         xTE1oDbE87Rb2l43UCdzolIcx29dKL3c7mMOn310bSGbbNURPzYbpw+Rp3g5nMXHmJWK
         dQ6Md0nuX/1p74Bl2aNLbMCB1UbRPnT1Sx2+QBy4Sq96IHHdgsEUUlPiD4ilscXSsnOa
         2R78b/TH35DrDw/3Wmxdu8LanVdhj/ClPwX9K1D2JcsuACFi0moJVb+zJth4uBsw40lN
         TWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779101005; x=1779705805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xTs49byiOKMbFqwJ3wm4pcmStKZPG6RE7CVuUJdE960=;
        b=XiaxG9U8y0otDE9EDrb/ddQ29vSZGPfDy8wS1PX/K4xiIb5kwHbU0eQJxRYo+JR9L+
         pljf1riliGLnsOIfdMu5OP5OOukedWVKmWnX3lnnYdiC/Znok8ed78n4GOoQ6zIs5JIp
         fGH0ZawtyZaOpC/Xb3HqiisZt/nwX0epF2AfTjQbf9tPi5T3z4Z2tJRIZNoBFJkhvlXM
         F2JM4fhPgDjNwuMwovQ2CM4k79A79wf4NOkmPydw5WGv115YaaDL4hQeBzqGhpXgs4g5
         OH3D/SbA/qa4s37ux9BaROodp4mstsT775s9IF8LBCGmwHgFscOEXtO6nyplYxuKJXsZ
         tY3A==
X-Forwarded-Encrypted: i=1; AFNElJ+bEXNEYkhCIyk8hyql66Jg83xM/s8ncEBKDgEHZ8TbvwTOYE2ZLnfAsG6Zek9D1CAeNfJ6/XqOsZ97DVU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxzByLz5bBnu12aL8W2sJwR9CINXexepzHlHJtXwiNeVnC4P4Y5
	lTbuxes6yg/opDdqNAqIG5ESvkmtlzZg1FvozybrLs5Decw0Nnjf6tM2gBwTJO2wh5jSIxEtgMp
	6W3xWYfhImoYTqc4mFXLRF0kiW555Oz8=
X-Gm-Gg: Acq92OG7SRMDOXQQXPbGhwVXP39rWeOKyMH/9vj5S/MirscpQPJiWD9Kpg6a63YIuWa
	ByYTIx1SaVnlRVKpNP7/j2pccE7+KT8hAEJAy1tGiOXusrQhvhh8Jl/+VBvuEj9KMat0eXc389s
	AvwOirWKBTc1rgXsrDwm5adoB9VqJXEPOgX98txmzrenEtXGHX/Gt+zNf+AxfgN6hpu3g6vaak1
	2HDJBkT26bR4isIcOhvT+O7DzQfamOWKNgJpI5H9E7m4Fee9RcbCSYUsv+7xqDdLQQRMayU++U4
	mZVcCA==
X-Received: by 2002:a05:6102:3048:b0:604:f029:224c with SMTP id
 ada2fe7eead31-63a3d3257b8mr7204165137.8.1779101005079; Mon, 18 May 2026
 03:43:25 -0700 (PDT)
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
References: <20260409-anacapa-devlop-phase-devicetree-v2-0-68f328671653@gmail.com>
 <20260409-anacapa-devlop-phase-devicetree-v2-1-68f328671653@gmail.com>
 <20260409-foster-stability-f77b38c6f7a0@spud> <CAPBH0A_K39218+=QHJuEY+SbFk-nCnM=Z8RQMdHBK7SkCj2QtQ@mail.gmail.com>
 <20260420-garnet-goal-4a284a8818fc@spud>
In-Reply-To: <20260420-garnet-goal-4a284a8818fc@spud>
From: Colin Huang <u8813345@gmail.com>
Date: Mon, 18 May 2026 18:43:14 +0800
X-Gm-Features: AVHnY4KBv_ZQdvkIGsbW-uxlaqMRSavFFGW3n1uyRZHosIHDc_Hzt105zf4NdjI
Message-ID: <CAPBH0A-nVtt_KynVyThZUVD2CShoeOuMniwpOxs4+nPHcri7MQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: aspeed: add Anacapa EVT1 EVT2 board
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, colin.huang2@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Conor Dooley <conor@kernel.org> =E6=96=BC 2026=E5=B9=B44=E6=9C=8820=E6=97=
=A5=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:36=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Apr 20, 2026 at 01:41:30PM +0800, Colin Huang wrote:
> > Conor Dooley <conor@kernel.org> =E6=96=BC 2026=E5=B9=B44=E6=9C=889=E6=
=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:36=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Thu, Apr 09, 2026 at 07:40:26PM +0800, Colin Huang wrote:
> > > > Document Anacapa BMC EVT1 and EVT2 compatibles.
> > > >
> > > > Signed-off-by: Colin Huang <u8813345@gmail.com>
> > >
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > pw-bot: not-applicable
> >
> > Hi
> >   Could anyone let me know, what is my next step which I need to do?
> >   I can't find the changed in for-next branch of
> > https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git .
> >   Thanks.
>
> You wait for the merge window to end and the maintainer to apply your
> patches.
Hi
soft-remind for these patches merge.

