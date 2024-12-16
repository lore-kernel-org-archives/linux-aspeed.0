Return-Path: <linux-aspeed+bounces-255-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85C7E7717F
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Dec 2024 18:45:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBplc42TXz2ytQ;
	Tue, 17 Dec 2024 05:45:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734374700;
	cv=none; b=UiuLLBw58jOslk5rLiImk9x567tf+mReYvOveHF3Q3pCG00zKrucTTTfZaSzj5k+PII6PcsFZZ1md3/P9ITAa956F06rtnjafeUHLMDkxIz2SnGSHFoQsIkkNnE44lZHRL5cyZz+bPTWrGMirFXmenBRlzPqVFli7TjLqQbG0cH74nk5qFopJYyoo7dZ159Unvb5ShhBbTnGp39EsU/NaKMRR2AgUmrPZiShkwl/zNwLHHRW8mi7Xrxm1uqCJeu4ainoMVVcnM/EXY3MFoc/3bqy6gBoXz67GjEp3KTwyvKPWyt+HHZc5Vzw9k3VizoYUoFYgD9GvuqzUOn3zgDGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734374700; c=relaxed/relaxed;
	bh=Uy5TogmUO/LFZyCxZkXtCXKplw56kqYPZnvOjhju0LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LF+3lAPEzq+ckVY1ajq5wD3wzbdviS+7sHwTJLwWc9ZcXV3B3i4lknXZBBCVaKygLCGMcrnPGeqoMHmi8KdMGdpyisVHZlYzAysslnyOYckQPU5K0Wu38LXd08y2v1IEMg5B/hw0IK7bK5Mu/Hi6NADCDfW9h9U+3jNrK7e9OD3UeQh4FMI3KidP9n8dIVo8GG+xfLalYX8d021qlmDrpnJRSP44o18l9qCR4KnZtpgDM24/CTfddH3yOSFHyeGDDccGWeyH+8aI4tubtqpiD6WsixXzafbPca9XEI180+gXLVoyldUIvQIois/JkcFZicc4U0A4xTHtbNn6J9yO0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DKO6nTau; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DKO6nTau;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBplZ4qySz2yhT
	for <linux-aspeed@lists.ozlabs.org>; Tue, 17 Dec 2024 05:44:56 +1100 (AEDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-725ecc42d43so3792469b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Dec 2024 10:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734374694; x=1734979494; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uy5TogmUO/LFZyCxZkXtCXKplw56kqYPZnvOjhju0LM=;
        b=DKO6nTauAEpJIILbqa52tI8sacPkp6kPbtjdo29m2P8BWx+EcYbfXhtJyYcfLI526F
         /3XV3Ntg3APIF8WCO1lQp0z28qZ6MIDMKMpGmR44lHCjYCvU8iWUeQhxesIr4ji3GUkQ
         y7zzcdLWxsUjjsnwUdJmZYnXYuWYrFQdiMhRzCIFtq6I5sk/R9NT1uvs3SppKLzGXhP9
         jzHZE4I73vgu2xpyivuWPOY0yKDjYjjf4FVAuLM9GwQI69/iQ9JbuY3BX1ivBBRdaFXn
         w1hvRqECC2eMrt92c4twrbbOrXeysUgEw+FN7hJuS8wr+iFF6EXScwLl0xZjqOgjfM/h
         ii3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734374694; x=1734979494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uy5TogmUO/LFZyCxZkXtCXKplw56kqYPZnvOjhju0LM=;
        b=aCRe7MMA73pMwySf4UNtl0vy/KG0SRb1WMvzySRvAaxljFXCxmdqIBRmAHECQMqTVg
         pFQhuxHoHPT34vg7KA6xVQLNkk2ZpYf0SQC/Ayjv9CDhXSlzE1tjZBjFCXUbmIm4fPfu
         VhrgP5rLG2rS38TAO7iZwu1ukhezZv5IYE/2xrbDv/49Jw9UMQaUzEBXTv0igwZrl/J8
         ZkLlv3nBZT5AvVVawBJtmElUlegNSFg5LRGgNgn9rWaQMkMcc8JHzw3Fo4ryHsvtoLbJ
         3ZzKD/wMmciyb366J9aBlRJQTtEVFXtstc4HLvZip9GoBK2RSblNIZBq2ACiflhj6auk
         e7Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWS+0gQt8csmG1XY2BBVuHkvl1YiESuT7Ll+btiLc8NltZsSamfvoh7E/eGaFs5pdvrSbomxCrMnrUPDBM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw2wkx+HHkaRwc/TeDyDeg5xPE+kgw+UYSBRs0k8Gu9pPyspwc1
	B5DnFMVlbwTJkD4bwhvchwtgJJNPaZ2DUQYCg5pAL6IFHXjhh4Nt
X-Gm-Gg: ASbGncu6n26f1f6HGB/CNwxfq3a41BMaxUFgcmqS0gQnvwD5l8Kztp4sTR54sr6TpAZ
	1zs5FahUF/tH8ZqTgFp6919b21PCrgUZksqqjDRuve6NYqhHcnDhZx3xDJu24qTePP9gkaaYpoi
	f51qd29GBV1jb6n+hxNeDn9NJQ1cjev7IXesVV4Y0jSoi0MVtq9tC8PgmBU2BshcUAfuBoip9uG
	CexyElVq3+Mo0QemWjhUWBwNlzIj7NU67oAzoEqegkAM+sS+j95Z4gWnVqWDL+a9CwwZQ==
X-Google-Smtp-Source: AGHT+IG8e6Gmq7DkH/m0iRUYm3sVxn3mLoxGSYH+9VbhyIOnW1xJl8bcqkbPbHMff/wOuKaIzC7VKA==
X-Received: by 2002:a05:6a00:419a:b0:725:b1df:2daa with SMTP id d2e1a72fcca58-7290c248bebmr22022737b3a.20.1734374694201;
        Mon, 16 Dec 2024 10:44:54 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918adbc76sm5082337b3a.80.2024.12.16.10.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 10:44:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 16 Dec 2024 10:44:51 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	eajames@linux.ibm.com, jdelvare@suse.com, corbet@lwn.net,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	Delphine_CC_Chiu@wiwynn.com, broonie@kernel.org,
	peteryin.openbmc@gmail.com, noahwang.wang@outlook.com,
	naresh.solanki@9elements.com, lukas@wunner.de, jbrunet@baylibre.com,
	patrick.rudolph@9elements.com, gregkh@linuxfoundation.org,
	peterz@infradead.org, pbiel7@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2 1/4] hwmon: (pmbus/core) Add PMBUS_REVISION in debugfs
Message-ID: <6604eea3-de0f-4d2e-bc12-7f75012b949e@roeck-us.net>
References: <20241216175044.4144442-1-ninad@linux.ibm.com>
 <20241216175044.4144442-2-ninad@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216175044.4144442-2-ninad@linux.ibm.com>

On Mon, Dec 16, 2024 at 11:50:39AM -0600, Ninad Palsule wrote:
> Add debugfs file for the PMBUS_REVISION command. This command provides
> information about PMBus protocol revision number.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>

Applied.

Thanks,
Guenter

