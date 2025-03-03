Return-Path: <linux-aspeed+bounces-917-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A377C282D6
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Mar 2025 22:41:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6DLg4y5xz30Vq;
	Tue,  4 Mar 2025 09:41:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741010657;
	cv=none; b=O1/jd2feLcBq1iqvmHODEDuyRFgI+9fRLMbUEAKvg6WDEHiQ6qIncfYqGPnyCMagkOplKTD8SmFu8S7CT/DjPOHwT6EEmAHMSs+u13ldI0uIKZ5amY+/9Jj3OKQB2oztzINpK/5AqL/pibeTxoU0fOE2Fb/yNZgWctr0L4+18+OIzHRan6sgvCzXfOITfmIBu+zpQkJIM1odRCJz7rr02mmieuEtmubO/YRo4iy3fz4thZwDBpTX8X0iEOBTYX5wSiKWOmx6YR8yI3e0q8uECbVA3y8rx+qefe3Hm6haMgsHDWF8ShcRSFvkL32Wb7SN0UEY3wyZvSoFLKAz0wKKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741010657; c=relaxed/relaxed;
	bh=8k28ohh0BPSZHJHOBtNIM4qll2UGyVczMLoUtKSqo1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyWg1CX6pCJVEtIaCorSxfGhPYj770ASdC/95qV/ntq/O+Zu5QIhZ5Rc/+CNOBg76xTm9yoj9HrYaau7+uCEaf9GwVJn6dMw4tukq8iEY53ydFPCdbUJxFoBJ+PLkEA6f2Sbx0tQg0iQwlV0dTK+7SqAqx4y37Jqc6P6d94VfO8Yl53fWQcAAODqd20ev8zJdvLx1mrF5GcsLxKp5WVFUe/v2eagvCI08fsEeYRAjIH8tgdmxnkBuxPI+qOpbd+1/1ahQRlttkHuBcNacYLVkJpT7/d9LSoUpCkPbCiT/26GA9MUB6JMeur/gWHjn0a6ofcppEJSa5iZllJEwNotdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RU03gmJp; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=gomba007@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RU03gmJp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=gomba007@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z60t7637sz2xgp
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 01:04:15 +1100 (AEDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4394a823036so42853785e9.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Mar 2025 06:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741010652; x=1741615452; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8k28ohh0BPSZHJHOBtNIM4qll2UGyVczMLoUtKSqo1k=;
        b=RU03gmJp4Pdx/NnpJ9m2uCaw6gW9MU4qr9DdHpdLUq3LdRhXWMWMc6E09NgQCM089g
         p0QrurjRTJj9q1w4YsZi408fPN2CIFHQs/cI3LqTa0sWQTvbJVHOEnEbuVMN0TSVehoI
         bMomz3MWz8fygRSqfbxxCHYpssxNVq23WZsf/T67vev196LnFomj/1kbTTGZFvjf2MSa
         7/ICdnlTeq13ZM1hwapymYyOR0A3cgS2gNKgF/Stl4WRyYKR0W/kFYjqtQqCuhahzGut
         Gj36GTjJ3zQKi/kYTuKatLIqfOOWcVT5j1YeTuibQRKJewDW2RYwYW16eM3wKsJmTuGn
         mt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010652; x=1741615452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8k28ohh0BPSZHJHOBtNIM4qll2UGyVczMLoUtKSqo1k=;
        b=cCuOpaDlUjiR3U+WN/n4toMAO7UFTAKPjt/rR1ya8il27ITcPfYdE2kNPbYB/0pr+3
         dMiY4uOxlK+FS8NzDihp6+DcVjQ32drLSmJf3wr10mJRF8OUpX2KvN0QiU0VITEOnbgZ
         p3dPtgdKMVTzz8qizVqqJQSHg92NOYghPMsK75xo/2NdFHDsbOZKrcQrChv5eu0IojlE
         Xmaa8EWKo9y9N2/mk807pMllJmr1WCRjLjS5r7TbbKDedUHg6XM9hYynG9eGfmyuYj/C
         aXLEFDeSzcnsUpmuNEw/o1kgPuxh7Nnd12VwINrJ5MSerkijNKdBJwQC7yxTb2YKYXn8
         maJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfoOKTE6LZC/IRBiTNHVgWeUOyyCaH5VYNxMmj0iVzaRzFbV4NR2vO+lC3Xmg4VKNqNJpSokoP+k1kUWE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxNzAGInB+A5dSLj+FhIbutLF32S7Z8eQSd6MR/xAcLBDbT8Img
	GoMe2sj+rdWYb1HUukmPey3lR4cEwAtIqaSawKkQAJ115wyd3Z0y
X-Gm-Gg: ASbGncuvqwLIoVHVFEv3kk7RQQDNxXk+iDsTQJBfwwSOQ9DGnPPxanpOP5dVvDvSvW9
	eKbwFDqap1iy53yc2tgALbyObg/h4x4UvRJBfZcV0ugVRKUpMeMl/LTTk9EgVgZxLrRMpN4s3xA
	/4Eot/BwlNlasEtfaLFA/eelwFLaVe3DTsGi0YLj04/pgws8e5Vg2tej/EpYcBiXUOmLaEbAAAp
	68VsPZQy/PWg85BCjZjX7hv+if4htxz17a0DUtbjTs7/HT6AfjZyQCLS5IF+nfU50z1cxaS3buS
	cI2BwE6JoxxaFUmoJ9AnF2cEKe8wuiyGwbW3K/r0cUkHWL7YvlPwejbxS4ZFq7nnECuxXI4bdPw
	lufo=
X-Google-Smtp-Source: AGHT+IHvcHXOSeKhHWMUt2xXWhTV53mo6yshUFDelmHEDhBHpCQfhR1rFavwoCbMnPzni4lL0cMigA==
X-Received: by 2002:a05:6000:1f8c:b0:38d:e48b:1783 with SMTP id ffacd0b85a97d-390eca27761mr8649282f8f.42.1741010652096;
        Mon, 03 Mar 2025 06:04:12 -0800 (PST)
Received: from ubuntu2204 (207-pool1.nat.godollo.uni-mate.hu. [192.188.242.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47960b6sm14936073f8f.17.2025.03.03.06.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 06:04:11 -0800 (PST)
Date: Mon, 3 Mar 2025 15:04:09 +0100
From: =?utf-8?B?VMOzdGggSsOhbm9z?= <gomba007@gmail.com>
To: =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Hans Ulli Kroll <ulli.kroll@googlemail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Dianlong Li <long17.cool@163.com>, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 13/18] rtc: sd2405al: drop needless struct sd2405al::rtc
 member
Message-ID: <2gfjdazu2ohv4evd7iuk2dzexlydnd6yu3xmjk2lgsx3iws5sa@xdwf4df4ojck>
References: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
 <20250228-rtc-cleanups-v1-13-b44cec078481@linaro.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250228-rtc-cleanups-v1-13-b44cec078481@linaro.org>

Hi!

> We can drop it from the structure and just use a local temporary
> variable, reducing runtime memory consumption by a few bytes.

It works on real hardware.

Tested-by: Tóth János <gomba007@gmail.com>

Regards,
TJ


