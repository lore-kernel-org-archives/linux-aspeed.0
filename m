Return-Path: <linux-aspeed+bounces-5104-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3B9CA5FD4
	for <linux-aspeed@archiver.kernel.org>; Fri,  2 Oct 2026 03:51:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwvwb0qJgz2y2Z;
	Fri, 02 Oct 2026 13:51:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:39::a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790910304;
	cv=pass; b=f0eCBPOqCNJH099OBOm4tkl7by1uBTOQa266stN9XiJyjmMoLuKzrnzJDHtOBIO8LS+F3Cwd6n2l/+cO98yisPx+W06OLaHHkEvsiKOvoR6rEJmR7FHv47I+yEwibrwQheDQ6KZ1UfYB0k0h/5EMPvRT7Or3o7nG2pBMzJNSM2Vjcyk27uU7GJAQ8+FHUQpS8ftePeG44YE0WFof0Z6xPSWJXf43bzf7pLAvBQhFsYltfCs16YAYRN8ZD45nrw0KenLLnHb6CoIcQdtXGs0jBu1aQWpHLMvDoDCeJmFZ4Bk8UIYCVXnGJSxIbpLHYKR8zBJz4e5BHgqDjvSpm5kFvA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790910304; c=relaxed/relaxed;
	bh=S+vkIWLkZtH1qHq8zaiVAp0v80XL5+eda+lNoFZJXU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2Pq9WwA9HG4pkPTm2RSD0vgtAtwLgeOR+fSM5z5/JrK5X19cWrMGg8gMOtezfRPQHAnHy5WgZgZ5cFqGzFdGEkshfiecjZHlOCxOUut0mZ99/ncTxyfrc/YkUyf7kPlpZ6gl54kd8RxpYiIMlQzNvfI+Hv2xbsncRrIfTC8migyi6aDbsv7KhD3jwNkA3mLINWMBA/rI5+AI8i7pr5MgVLGAGFyR5ZkKCqE0Yi04aT8kTPfumq3O/3NcyK7yOdlmOwECyKz8kv1VTCQXGqdbjGrjW8R4z48lOfSz2j1Z08z3WJBFooXmNP+PzxvoxBPGZZPJXbkQ+pm+HP41ToCQQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g6UthauU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::a; helo=mail-pj2-x0a.google.com; envelope-from=suwangquanta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g6UthauU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::a; helo=mail-pj2-x0a.google.com; envelope-from=suwangquanta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0a.google.com (mail-pj2-x0a.google.com [IPv6:2607:f8b0:4864:39::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwttk1Gw5z2xwd
	for <linux-aspeed@lists.ozlabs.org>; Fri, 02 Oct 2026 13:05:00 +1000 (AEST)
Received: by mail-pj2-x0a.google.com with SMTP id 98e67ed59e1d1-3a4fe110578so988525a91.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 01 Oct 2026 20:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790910298; cv=none;
        d=google.com; s=arc-20260327;
        b=hScZw/J8cYQU0xoDbroBhm2l7PhVTERfuZqOXDBXfbgbMmRVN98TFOQ49qBMUm9K9p
         M6t3Bejx/zwWPEBYk+BBKA16uyhPsCv/yx8u9AuSc21V89fYhhqjb5Ci/HcqjT6efubX
         ShnfTkxt37T3I+XPWaarxXaJ7xz9fcnEiFowypRbBtiJ9ekQ6K6XY8FmQPeGNLYYF/2p
         dYGrcIa/uxKRsUD3ir9RZsssha5HYybvUa72Yeqg9CGXM7Cp7e0YAUND9ZFr3Jp0TesR
         gZ+0usvCRS+8JZQsb6a6n1XY2na1U8C6hO3TkBzSu4s20caotaHqJ03IBFRNypG/iHwK
         /vkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=S+vkIWLkZtH1qHq8zaiVAp0v80XL5+eda+lNoFZJXU0=;
        fh=SC2u8UkdZBLo4glqcGDHfeFRbOLyTdlCtN2pwVqsbRE=;
        b=NRoQj/HP6yym8XnoiraFIMx8RudsHBdAM3HPv+hXyVcelXnJvLSXIsvHGfpKwulXc8
         T4rzXVgtp2c8flVdLJPRhiBGGISW6N8KxeHpqv6VuPwmyuzpXFigfxHr9codcX3oRsKo
         6Cih0FPwYRddpf/6LCP9va0SyO2JhyBoqrsOSXJElhT2NtQjbZXsSSHAtYGcOyFmXMn1
         lgN+NGCSqBZn4Aw3Vwz7hB5+BGdWjrgsqVa5YqErPtC1UWGUAY/TRDM8+hDjwNdhO6Yd
         Y6jZlzTOAZ3q7twOvW4epuy5NhEAnC5hnLRv6YUEYEaA/gAz0QkHWwnJYaqAia4kAEak
         4+/A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790910298; x=1791515098; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S+vkIWLkZtH1qHq8zaiVAp0v80XL5+eda+lNoFZJXU0=;
        b=g6UthauUGHG/hEzCSSdacyDlNAOrczhaLIoTb3L2VT+XyFnv37wqp7jix2atWalWU9
         UBlKwWOdFRpGWZSZSplwaiyCnWaGsJijexjFeg09e3P1a3/8yVaitL5NyIm/jF4MDpSd
         f2Uf3Gjcn/zj8VyP9BAk13JR/Llka9S/v+IgJA1UJq4Q5OHtb5Tn4p5v48SG6zWdjKh7
         e5fhUQPnbddtLgJwcQAQrRdsoz8rmyYnkbdcCR0p4jN62MEspjuH4aT1VzJu8xzl0Vyn
         MtDWYeymYhnfVA5nInA2UqKCvpVJ86sm0Hqu2x7qkpp9BGUQ2IoJT9AhixIhat9T0Agl
         pNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790910298; x=1791515098;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S+vkIWLkZtH1qHq8zaiVAp0v80XL5+eda+lNoFZJXU0=;
        b=ut7Ffu2sl8708FK0T62ko7OcgkBfXgcf0yZV3K5MydEMSNNGWcf1Koz4BZI3OZejQM
         9bHMVDzPrFchun0zshPB24z5UHKNb2rGNkWq72HUzYEbQFHAXeU3lHYNrzEFCu2TritF
         YXzKEZqyqenqiPYru3igsC0cjcVZUfvzuUX5XVr8HyzmIrzFOGe3mA4PFEZZoX759aNl
         3TYRZ8AnYCHzoVJWqBJmZTLuKqxNy6Xi/YMU3ZjDBvHRadszlO6FqBtaOJXVDH0o0JfH
         uL+oaVV3N33mLzawaxQgfLRXwAjGh+L3sHO8b3V+1GrtUS3L/KZLzpxVJcsekbqa18KZ
         9Tpw==
X-Forwarded-Encrypted: i=1; AKwUvByIA+S+2+TdrAOS0FXhm4LsN1gLOiKclgW4gOAZ4tRLGuE9WS8Vzv8DMapoaizFteMZp1ANyb8em6kf7yQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI7tXeOQefmccVES0UUjx/NtBat7Q5FoIt1kDm+bYBpytRx5fH/
	2MMP5Yd0rn/zk7knRuW1NZeD2nuWFn0jcOiyGZHwNpNrKWF/9N0DMvjROSscGNFEuGkjckFDY7l
	gCpynaCF4md5AebTY+7Y2RjOUEXHZD14=
X-Gm-Gg: AYBFou0KcPxmt7/R6Cm4Xe/3EcN96gvmmjvAvtTwKWHx5qxzSNIRTIrzgQH8eaurc5h
	9zvft3rURpRLk4OtaljB5bV2ArMemo2Q7CObSeC4l2ybrsbJl4bkO/5h1r9C3T5S8R83gDzkAqK
	YlRZ1CpnDV/esBa7qFJB36EKJ+o9Jb0h0/y/BfJF0EfCwYhFWogqm15panT0jOpNzJgXO12ogup
	yKQlx1DkxKWCPKeTu2YmiIqwifdKfpzFHRm7ouVDM7eKbXe7GLISg8P3PphvE2OPvP6HohFvAlD
	9IEYCq1JCnddfFBiQZ6t7OUCbEVUX84gHpCUV/YdMDS8uaC6GAlMe4JV
X-Received: by 2002:a17:90a:4ca7:b0:3a6:ddca:112b with SMTP id
 98e67ed59e1d1-3a6ddca11b8mr489962a91.21.1790910297480; Thu, 01 Oct 2026
 20:04:57 -0700 (PDT)
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
References: <20260929075106.74731-1-suwangquanta@gmail.com>
 <20260929075106.74731-2-suwangquanta@gmail.com> <20260930-curious-narwhal-of-calibration-62442d@quoll>
In-Reply-To: <20260930-curious-narwhal-of-calibration-62442d@quoll>
From: Su Wang <suwangquanta@gmail.com>
Date: Fri, 2 Oct 2026 11:04:46 +0800
X-Gm-Features: AclHuK-KfgGwZ7bu_T0onXf5TVB_lsME61cxwHa_OQd7XBi3kxomvlalflHsano
Message-ID: <CANoBHH2a_Qu=eMoQ9GFYYn-MVg7zhVZJbiBRP6L+roU2zp3d7g@mail.gmail.com>
Subject: Re: [PATCH v14 1/2] dt-bindings: arm: aspeed: add Meta Ventura board
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, 
	andrew@codeconstruct.com.au, ryan_chen@aspeedtech.com, 
	billy_tsai@aspeedtech.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, patrick@stwcx.xyz, Steward.Shih@quantatw.com, 
	Martin.Peng@quantatw.com, Fred.Zhang@quantatw.com, p.k.lee@quantatw.com, 
	"Sue.Wang" <Sue.Wang@quantatw.com>
Content-Type: text/plain; charset="UTF-8"

>
> On Tue, Sep 29, 2026 at 03:51:05PM +0800, Sue Wang wrote:
> > Document the new compatibles used on Meta Ventura.
> >
> > Signed-off-by: Sue Wang <suwangquanta@gmail.com>
>
> Please respect our time. Actually other contributors time as well.
>
> <form letter>
> This is a friendly reminder during the review process.
>
> It looks like you received a tag and forgot to add it.
>
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions of patchset, under or above your Signed-off-by tag, unless
> patch changed significantly (e.g. new properties added to the DT
> bindings). Tag is "received", when provided in a message replied to you
> on the mailing list. Tools like b4 can help here. However, there's no
> need to repost patches *only* to add the tags. The upstream maintainer
> will do that for tags received on the version they apply.
>
> Please read:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
>
> If a tag was not added on purpose, please state in the patch changelog
> or cover letter why and what changed.
> </form letter>
>
> Best regards,
> Krzysztof
>

Thanks for the reminder, I'll add the Acked-by tag back in the next version.

Best regards,
Su Wang

