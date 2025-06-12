Return-Path: <linux-aspeed+bounces-1410-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6712BC61CE8
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Jun 2025 23:01:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJJ174h03z308R;
	Fri, 13 Jun 2025 09:01:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749712079;
	cv=none; b=XiUfVMw/kC6MuNXFRBG3Eu+//BQTogLaWxL2mrAKzDnWZbi8O4I5uiuj4NCj3suuROoWCwqTbB0wlX4gPKrpyFTjGMvBHwGyFM6lTVCijD25FuKza/jJ2mKvWVT/C51SzuZUKiIRoQ2C6G7NXAzr3Vb/f+s1tKU6mI0pVBFkeU6O8gE30lfT9coSREiyjWx0RzWl+6yGwmRMAV6mRY8eIo0RX19Ua5bYCnmK4cPniV4bPSgWHDx2lKocoOJPTNNGPMDEO8R0v73zBTirfAmcxAC5nwmzgr2exjqzJWt1u40HeMPedLjIKYByGMH2OLr+usdl8jNC6YMpLuxOVtHj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749712079; c=relaxed/relaxed;
	bh=dAOjJxhCfv8VWKL7BVvY9ZNzsKcaY5YiZqclR7H4/vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnbgCbUAnRvFVz7fMPPIYFsg7npcQhMjQI7XPV7fGg4spaN4LkIxQMLNLQI09tXwXtHDV0uFX2r9Qvg96HRnPwEnnsnXZIB0Py0SOfHbfrYWkv6j/qTPU62HORILfNVSr6SCjqy0ieKXG+HNGfapAIh6pW0bH0Q4ktsEO+83PqMsEM6fMKzuxalfVV1k/CLrSmkwHHA373pIio58rRfdbE+0SQW/t6OvJTSgS2CoIlvlbnXPaLXKhNyP5FRWMOVPS9eNjDnKDdL9wCwumAzAIFrNz3zlUDRzffxNB80PGmjZ53sA3yWbc/hLZmQzMYGIFwFTR9f/56GjqkLG9mMq7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nYYvCaA8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=ankitchauhan2065@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nYYvCaA8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=ankitchauhan2065@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHtsB0qgZz2xGw
	for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Jun 2025 17:07:57 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso870933b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Jun 2025 00:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749712075; x=1750316875; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dAOjJxhCfv8VWKL7BVvY9ZNzsKcaY5YiZqclR7H4/vs=;
        b=nYYvCaA8AuzCoNh2xgip6JOrcHPH9pjg02cW1hBDvmIdHgnnsLxYg0H0Ms1mksDMzv
         fBnAZsxI1gmerJBr8OdxCCl8+aGyDSaupytcRZKzzmU1nHxlk8+3KXaYDlFo7RH7RQ1K
         ND2SlBPN7VauvJB1FGtlcyPY/XXcxFTvoeY1DGFWaI0Nn4eMv1iOqzPEkPCdcH+D6JnO
         NnuEBcZ8IC10qv0B2g30BDH2YrZ7HK9+l0pKUscpG32cETbGRJuZ27pqTC5ARSjMFgcn
         pxRBgqmG1B6khx5jTMInYM7/SQDEa0DLulWK1lVXn5EXgKoQvDq3ri4OyfJMoEkB4OZF
         vLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749712075; x=1750316875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAOjJxhCfv8VWKL7BVvY9ZNzsKcaY5YiZqclR7H4/vs=;
        b=F0zL3oCpoH8jB6zHtKquYVYJ86pjs71LZppUf1ZQ6vQc6jXlfwqQJ5Adc00I8Zh0OJ
         vsjggn73MjUx3VTvpC1r7md71eUsX64s/XcZDbgeABLLE/mhJoRK2opMYuwH6TNwrETe
         x4D3U8JsJpvhdJ3AIZayPSIBzMbmy8i4GcW5ALoj1sYQ86kP2565l6V46Z2w9M/vHrbr
         HqovocaFEFKQD0QbUxiosNzK2Oejozas0Jh7f5Qf32VjCuvPA1GDXMInOL1SEggBCtWh
         a236FWY8bXreodysA4Zq+ICkxgmv6sLEmGJuPo2PDkvNnafnylQ+NGPEJrzxG8lf2eqa
         VSSw==
X-Forwarded-Encrypted: i=1; AJvYcCUYie+FIYjTbZ8L6VUuUqtcanK6zI0Ietffl8YMd7vNcq9QbclztUfabe9KcFu+mAta1mOr35DNrB1WSPk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzzKuyE4Ye9mqKs+6lPnbR3+Ybnmm3TTjmq1l5OLWKv8p4non/e
	VQ/HxQCWQELUD17KqgJjFVgTCzJBzRJeMIGp4EIT7ZzZKyO64ZYRCpPfb7k6+v7BsBA=
X-Gm-Gg: ASbGncuzfiimlgQS1aKqYAM2rPE0H1xrWqU/WdoMwah2vLtEfp572APUl4PLXzwuvFd
	fkxnW1GY7qoukkNflCrVsNBJHZCElOL3jw67gvVGvUiSNIlTjt8D8ZPjiewwtgA+AxZG8E9JjtQ
	YxEBStaY+KYLtqECWtXjp5OkSLl2mTC+6mZjk72NIyfQp1GF3e5gMntaawrBjkeifju6HhgsQLi
	mDqhLzQsmwlcMioiYhWBE/1Ryny1V1k0xR/TbIl7yE1GdLCDBrpcbrVx7sKVZweCC8jmtvNMxoJ
	J1ZFeNTKMbqLBEuxbCfH5rSYuswG9bwurtze/2F1VNUJFt+DkqixebzhYxPde1JuaqDf9Yx5fQY
	luFqEv8h5P1jKtNNFbM2E
X-Google-Smtp-Source: AGHT+IGfi33QMmP2NxREt3lPErfPBTHFxGftgC5xTDBsF/Wzhv8TdBvW48FWIe805inRamkcxDRnzw==
X-Received: by 2002:a05:6a20:729c:b0:1ee:efa5:6573 with SMTP id adf61e73a8af0-21f86600846mr9497042637.8.1749712064431;
        Thu, 12 Jun 2025 00:07:44 -0700 (PDT)
Received: from ankitchauhan-Legion-5-15ITH6 ([2405:201:4042:d128:1895:113a:65dd:3ae0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74880a06b64sm738064b3a.143.2025.06.12.00.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 00:07:43 -0700 (PDT)
Date: Thu, 12 Jun 2025 12:36:56 +0530
From: Ankit Chauhan <ankitchauhan2065@gmail.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: lanyang: fix lable->label typo for lanyang dts
Message-ID: <20250612070656.bir2ywkwu27gxs7d@ankitchauhan-Legion-5-15ITH6>
References: <20250529-lanyang-lable-fix-v1-1-8a2dcb48bda4@gmail.com>
 <3fe9885cc54a328932915a63816ac1b7952689a2.camel@codeconstruct.com.au>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fe9885cc54a328932915a63816ac1b7952689a2.camel@codeconstruct.com.au>

On Thu, Jun 12, 2025 at 03:01:58PM +0930, Andrew Jeffery wrote:
> Hi Ankit, thanks for the fix.
> 
> Regarding the subject, can you please use the prefix 'ARM: dts:
> aspeed:'? From there, I'd prefer something like:
> 
>    ARM: dts: aspeed: lanyang: Fix 'lable' typo in LED nodes
> 
> On Thu, 2025-05-29 at 17:09 +0530, Ankit Chauhan wrote:
> > Fix an obvious spelling error in the dts file for Lanyang BMC.
> > This was reported by bugzilla a few years ago but never got fixed.
> > 
> > Reported by: Jens Schleusener <Jens.Schleusener@fossies.org>
> 
> Please make sure these tags reflect convention:
> 
> https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
> 
> Rather than spaces, they use `-` to separate words, so:
> 
> Reported-by: ...
> 
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=205891
> > 
> > Signed-off-by: Ankit Chauhan <ankitchauhan2065@gmail.com>
> 
> Finally, all the tags should go together in the 'trailer' (final
> paragraph). There should not be an empty line between the `Closes:` tag
> and your `Signed-off-by:` tag above.
>

Hi Andrew,

Thanks for the feedback. I will make all the necessary changes and send
a v2 PATCH.

Kind regards,
Ankit Chauhan

