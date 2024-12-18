Return-Path: <linux-aspeed+bounces-281-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BAAE77187
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Dec 2024 15:15:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YCy0f4ns6z30Vw;
	Thu, 19 Dec 2024 02:15:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734534914;
	cv=none; b=GF42oeJmppYOXHMM4hisHkbCstl023Md6xC8YuSyLCJ7P9kPRfas95mnR8zHJoKBTAm3o9kcsPAenJS+zYEVLyiXCeOoW2nEZOtWhqQ9+mDCJPgrJ1IRuECIuSklwOsj7I7PV9q+JTyLdQxtFbQfjqfbzQRhKhWCtrSyRTgj9Qn7ig02a5ZGvh0ZsdPP/dpdUm9+Nede0i3ga/PItL/VnslkDDYgqBzqvoXPxs3/zt0W1T3RCc/qxw31ct0/Y1bywsV3KeUyMEzsIBZxL8WGS9asnDAhlTnt9aXKBxFIb3Raay0wMklSqa7Gnm80x3hWVt9P+JghiT15zRAjyhHt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734534914; c=relaxed/relaxed;
	bh=1BniwaVTCowROQnATdcgMHlEoMA/xTtbAYFVm4+9btY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBTwjO51SMenVvW6NhguppL9//F6rde25U8GiBZYHDL6WONUtyDtJOJ4H/yhKOTY5Bfl5KpuK5GqK7hzTyV9rcOLp+wjy8H96oJa6kQAlL8tFqrhj+xdoElTwdEhKyhSRaC6xu2/tkSkdP1LeLax2BnLBzaDLj0355++3DEcBz4PYvVT1uaulc27L3AJ7UOJWhzcl+2BNeNmF/UxDodw8tgAoBEaakdYmg9XNXCPPVVNPoZri9hmdiNNNQtukpTioIsAQ9LCNwlNxMGEeYcfu9WnJ07+cMtfSLWhp/zf8W8LGmb7CCKhTs5pqDPZlqIK9MI+ysdGK9Rs+jCLkPvf6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KxM8dna+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KxM8dna+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YCy0d5Q7Hz30RS
	for <linux-aspeed@lists.ozlabs.org>; Thu, 19 Dec 2024 02:15:13 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-21680814d42so56037215ad.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Dec 2024 07:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734534911; x=1735139711; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1BniwaVTCowROQnATdcgMHlEoMA/xTtbAYFVm4+9btY=;
        b=KxM8dna+3sNeBEtZBD+1+dA0A8XbpM6sNtT6ZcR1LMv/4qkWzB8A9bv4RAdo1PuEVv
         AXZnLy/izU1Kk3aQms0NfXC7D6KcRJdAZpNFE2tBVJUWm+0jyq1sY8/UHR34ptg2nD24
         G1F1MSDKoD8i52Sla3O35CWN4Vq0cnuBs0M1Pgnp8Tw67jAaqW3hwS/sDX4On7QzW8eG
         j4+9y1JXSm9UWbLvaajzoK3n7YMCJ22Ik9v8ThCM4ZtWKqFXLJA/mogSNmDkeU61EKvh
         VSoebtv2ovWPjtvRT4NkJmn4R3oGCNE/zULtpfddkrwtW9I545QHZfUvqkgNi3X77ZtM
         Ha5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734534911; x=1735139711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BniwaVTCowROQnATdcgMHlEoMA/xTtbAYFVm4+9btY=;
        b=un8pAgxxQbMQxyhOuA0esDpbq9+ssLcMDkex4f7rQH5abS4eTDiSE26ozHU3ti5a2v
         ih5GPuLtDXXIKooYJTWPdZOlN60HfxU7TXOhfMbu9zJ/ImTAItdjbvWr2/uv0yfP1P2/
         N4v4yqF4ZpfCE2LeaJ5nREfjze9bvJqU99rNOC0xxonP5ZnB7aKZvIa7Q/YWFUBeA8dz
         4T8XswrIKa1v8JMIp8p5P/kmgV9MkUkeEjwS7SwVTgu9d7J1+Yhy15OMsXg+2+yjw5NI
         mW37GTGYCLYDoA6jyxUNt0qUwgB6jb3QXv/+REzlkPuyU1LBj4Mgx4QohVzsuguiU3Jg
         jRzw==
X-Forwarded-Encrypted: i=1; AJvYcCU8Oi58Rnkc+K6uEHV5VWeqHeGy9WglzmSQBO2/HEqGd34Y7T9OwE6Zwu1240u3/N84PfSVLzxtSvnwbYE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxfzB0ocmxLato+Wo8uI7l7gzEuJuwRN0FAJP6iX0NY3TleIjob
	7VPwmRjB9IHbCOiZNZhPda8lSXHwgNa4BelP+6FlIaIJmg22KYuQ
X-Gm-Gg: ASbGncucNVUF+opsO1YCDyOPxgN+oT4hxEyxE2B0XJcxK5rSbzu67/aMt5toj4joof4
	bB087J6kWDZ6Cijc9FGfZUXcQxKUV8XcdtBaoeJYZSm7mgt2R1+xe0+NN1bD5D6AzNbXZm+5ykd
	UI1RMGhEa0j04UVURUBmrYdd2YgluAcSHuXnua1c1047O9hcW8Q0ZBCwNleqxY3VXWzU3CtUdgI
	66x4UAM3dL1RnVj9+FtIbfM3p/awR21M9SSgAIwl+TXQt2dth88ufHwonu4l5IqJyelXg==
X-Google-Smtp-Source: AGHT+IE/4h1YDKKtjFs+zOt9aPjTBxQjnBuzdbZVp1TZRkO/LfYMNmgU1weizT6Rb4caps0E/nTJOw==
X-Received: by 2002:a17:902:da8a:b0:211:7156:4283 with SMTP id d9443c01a7336-218d7252824mr43701715ad.43.1734534910892;
        Wed, 18 Dec 2024 07:15:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcb47dsm77953085ad.61.2024.12.18.07.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 07:15:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 18 Dec 2024 07:15:09 -0800
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
Subject: Re: [PATCH v4 2/4] hwmon: (pmbus/crps) Add Intel CRPS185 power supply
Message-ID: <3c7d8856-d58c-4ac2-84fe-7a7374fdddc8@roeck-us.net>
References: <20241217173537.192331-1-ninad@linux.ibm.com>
 <20241217173537.192331-3-ninad@linux.ibm.com>
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
In-Reply-To: <20241217173537.192331-3-ninad@linux.ibm.com>

On Tue, Dec 17, 2024 at 11:35:33AM -0600, Ninad Palsule wrote:
> Add the driver to monitor Intel common redundant power supply (crps185)
> with hwmon over pmbus.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>

Applied.

Thanks,
Guenter

