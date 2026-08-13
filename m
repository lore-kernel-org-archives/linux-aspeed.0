Return-Path: <linux-aspeed+bounces-4726-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F37C5DF66
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 01:16:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLknr13bWz2yrw;
	Fri, 14 Aug 2026 11:16:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::e36" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786604866;
	cv=pass; b=EQOsylHeY3eLDmpRYSHCXLd5eG3VqQKovfI74xUGt/GZGTgDE93TgzeG8mamD45EswJRWU+Is3irvoKTkI8BR8PSIxlKeyB8s9jkUGtv3LADmgsl6bnAi/PEEXYaM8Q16JnIK5lPU0MgmuB3tLzTNm0sxocF2L/iQQNc16/p7l3ajyZj2GWGWlpjlbAl5sYoSLlMuxnGwck46/QaTAFlSv2JpitAjtxiDixJQfpqSlclgLMfVcmCp/eHXfWZH5OQSWSd0M4UcTj/Ugd8W99DpuDIWEXN4pFe4uQPOzp7NVUJSjXuQN+8K5fPjqcTD1S3I9QA82MywCS2DcuDqenkwQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786604866; c=relaxed/relaxed;
	bh=JawJ392oLiwqJSSKv/chS0lFTdfl550m6jZnWA87huc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8HPXrS9sHgyz0Wf8iJJpNYtRIo8hTbGiOhDgtXaLuy/dzr9W4sP5ePnS8ERFhTTVXjfFACbO4LSR4UgjdfIAWa4GHDKPEl+agXXB0o/84yJQJQzyovRlWy51EGKzkqHhCetiJJXP97mjqfckYaQpSNeoiWEG0t4PBPQqlTTenpMosH+TpLdPzy3Vu26Hi8q5VPjDRB9TSTnp3wPpqINHP/u/NFdulrkDSPN+AExducW/7g0LRQMxkZKaxM5ieK7L+WcRUJ0zgJ2l4nh00aGHW/Tws1XbdwErb0bLuZgkNujBJs3WL8pRf0JJK0YHVpPod2CRI9ZdaRfTbtiYHuVNQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HHhqvr5t; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e36; helo=mail-vs1-xe36.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HHhqvr5t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e36; helo=mail-vs1-xe36.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLGdr1vLzz2y0B
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 17:07:43 +1000 (AEST)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-738bcf9a573so120593137.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 00:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786604859; cv=none;
        d=google.com; s=arc-20260327;
        b=CVfPM22wCsXzCq8K2d4x0QBYIThD3tikmy27xoaoPBzcBuPXJknnAWPEyNtm1mvFyB
         IN7B9cdL+QZLOlaPttcpZk5P3apyw6jm5bSgdQaIFlF04X9BQrqAEIPhA3YOM2CmEebF
         YRQ7pI2ti7mI8IVsYf+u0iBAUt8JPEPo+bITYtD7fHdAQtNczgLGM5B8bZbsmheYhDic
         I25xmWsBKzxzbjxK1Zd33YCE2RBeEx87Qdrfk5o6SQrswrR3UKCc0eD4sxlYnuLK1fOD
         Z08u1PIWRKgra8Jm4lGB7bwAq78aUWiVRGG0AVqAWALERKe7OjzJWXArGl+u2UsNn7VS
         fILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JawJ392oLiwqJSSKv/chS0lFTdfl550m6jZnWA87huc=;
        fh=3qhvSi5Tsw4XLIAldejZ2uYVp4bVhCUl5B+UR4ZYKJQ=;
        b=bIzB90MDiTxKKVW3rLKmYqxqFpMW8AleJzq7EEd2PGScgbzK9zrXtiyBI245hixH/S
         YvYKHWelN4sso8Xf/0L07X76WDiZhM9Tm/DjPWtzOEn2srPIoTOE/YfWaTtEtgM6a836
         qdIM2jvx4843OBO2b2WKKuXTIA2R49em3W8kYxxFtScGtp1iIagdyl1qLC8XVrI4DVZD
         0mIAn2LzHpxn72kmkI+Hrh9qFcwtReB69NDk/dDTxz1a6+qAv1Dg81H4qA4hmkSUXxhC
         ZsgOIOjL081FZfYdYW2NI04swZDMNGqEs3vRN7hPtApTOD65GTE8S72XnR/7cgz4DhDh
         c6BA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786604859; x=1787209659; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JawJ392oLiwqJSSKv/chS0lFTdfl550m6jZnWA87huc=;
        b=HHhqvr5tlaWe1nGbz1IgJB0i8O573Ha2D3GXn3Faw+p55InE3jqj90peWQ4HIy7rlb
         HJIbCgtpR+oD3a7NQJ7SOFos/PHWu9eiF7Im65UeC9B5ioA2qZB3WGrn6GAR9ofqwxDg
         PdG+lhOgCUx3fCJdwwwAitwGWC3r2ySl2bMBXYXNTimhMTqtwgs8V3jIo5tfrN4y+9EU
         /XY9QRI+EOEe6/kiDwul1995/z/xxqhDUZFzdt3GblbIidk3DBr6NPvaX9yWcjbBlcXt
         B1IVjp5Zv5OMExeQKegEL9sMJCA74lAnX4mUz0QInxbRV+odk/ctCJNfQwVoMRceJi1H
         t8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786604859; x=1787209659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JawJ392oLiwqJSSKv/chS0lFTdfl550m6jZnWA87huc=;
        b=eOAAkV9C2U36sk5lPsos+h9cEvOXjPRJK2YiYfKbX0mze5bvEoiIHSWlQVC+XEu/ej
         4XlBpe1o4ITnZVd2B59SQKbU4UkxczX2aAeT4VIrlyARJwZzIxJyNpL4cRR6zDLICj3T
         y0XvXAgRtVhV9EW7mQgGS/0L3W46LFyrXyM6tFvfBEWlqAvvoe6rMbAV73boLcb2vymc
         jhjnem3CraTWoSD7rdRmYUCdZhmndNl+s0ESGWDZmMW6AXyjiYd4Wf0ZODwIDLBtXvU1
         pT4bRLGUYuVby7wgdfG4gZJr1PnCVNLwYHBukCtJyOsIOntINLFRzdUfxp2+1ymQhQRu
         ciJw==
X-Forwarded-Encrypted: i=1; AHgh+RrsSPYhy6eKYWBEXzo4LMpA2PoY9j/1ewD6MaBpO8GMN3BIHduZgmxoKDY4GztK0K5wrYET8q23IJ+vbB0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxHRr6zebZvMTTDWo2tAvT2ssRmZRK5xRd9F02hCFGBno8Nfmpq
	FO6CAuclHNzYOSTdzCCy5+lTDw8OKjmKBFlw/c6h/bGRNdlhq5A3H5821629rMmj5fuFlFQP/Ri
	OuZGkLhRjc/MoFWLUp9ZQbvz7PtpWweA=
X-Gm-Gg: AR+sD13cyu1FTsAcQ5GGfyy0TvYWfgHt6xQj1FnUdBv0YtXNjA/p91eWYEW34lHTkU7
	yG7idac8AgrKLDyPqvVYTCmCrXwY4qHGLUOGdD3GMH8F6wCmuM2AZK6wx8dNmLc5t9IE5Z5oWzs
	GGSFTPGVj81g1SZd4tAyadluxh5SlnrccX8e7UtJmIHbucbyXQGxnGFLQubmjH7Toe+thRn/wXM
	eJVWgbry2pTaEMZFzNSBf0UUlB0Z8GTvNe9rirkys4kAcgxjtyANMILwogsOmdgfvUNomkij+09
	y8S1Bc9qDRL0N67QP1WwjKrzx9NVymWHOhokXnh1cZdmqrmQfhM56OWpNQ==
X-Received: by 2002:a05:6102:f08:b0:745:6721:8c2e with SMTP id
 ada2fe7eead31-76db527b110mr828054137.2.1786604859600; Thu, 13 Aug 2026
 00:07:39 -0700 (PDT)
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
References: <20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com>
 <20260805-anacapa-devlop-phase-devicetree-v4-1-5d67e0efa6c5@gmail.com> <20260807135417.GA63178-robh@kernel.org>
In-Reply-To: <20260807135417.GA63178-robh@kernel.org>
From: Colin Huang <u8813345@gmail.com>
Date: Thu, 13 Aug 2026 15:07:28 +0800
X-Gm-Features: AUfX_mz7a9dcIAK-s5cvIzuRv5XGFroygtfy3R9a9idtSFOSgE2XnApE3cVRlPY
Message-ID: <CAPBH0A8NjrYVGdPBegFo+DcZDL-YGRHAzC3MzDc33Gvamd_dHQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] dt-bindings: arm: aspeed: Add Anacapa EVT1 EVT2
 DVT board
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, colin.huang2@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rob Herring <robh@kernel.org> =E6=96=BC 2026=E5=B9=B48=E6=9C=887=E6=97=A5=
=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:54=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Aug 05, 2026 at 09:02:29PM +0800, Colin Huang wrote:
> > Document Anacapa BMC EVT1, EVT2, and DVT compatibles.
> >
> > Signed-off-by: Colin Huang <u8813345@gmail.com>
>
> Missing Conor's ack.

Thanks for this,  I will add this in v5 patches serial.
>
> > ---
> >  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b=
/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > index dd7996960de3..1c2656d99807 100644
> > --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > @@ -84,6 +84,9 @@ properties:
> >                - asus,ast2600-kommando-ipmi-card
> >                - asus,x4tf-bmc
> >                - facebook,anacapa-bmc
> > +              - facebook,anacapa-bmc-evt1
> > +              - facebook,anacapa-bmc-evt2
> > +              - facebook,anacapa-bmc-dvt
>
> alphabetical order
Thanks. I will modify in v5 patches serial
>
> >                - facebook,bletchley-bmc
> >                - facebook,catalina-bmc
> >                - facebook,clemente-bmc
> >
> > --
> > 2.34.1
> >

