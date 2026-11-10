Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3518F606A339
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Nov 2026 22:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=E+qpiYl1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPMM44xQKz2y2h;
	Wed, 11 Nov 2026 09:50:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794351056;
	cv=none; b=Oh+1x8Gce23aTYGWSSQKVcE0//CVo5eDzGX2k5YFGwra4bUMAjFaEsH/2nkFbH3FCLo8uW201G8ubvQ2wdU2wInrYv+WFeXC5kzM7Wl8tfFV2dmQG20TQ47HgW9rMlqVR6mo4JDM0CaeQfs6kRvkReTDkzXHu5hNOZSXsvAboKByEbjZmvhuacgyiY34uxPtJ2XmIqlGbGDktWh5nNc1v71TBi/q5nbymOOdAAW+fxYe0w+pKPR/Ee6kwsai2TwWYDscPaHFRmC+VNC7DctJdtSuRkhpWO4cf9kzk3CiM42VwXUOYel5mN94ouleI2g2aps1TK1TE6k66IF34evk8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794351056; c=relaxed/relaxed;
	bh=eh/GkHmVLemeAYxVqb0jIsD7IgzOXsSMzWc10IqxN3I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iUautr8HJwKGbVe/QDgh/k7rndkgeGD/JKLQJAAE47WPRNn8rPgT+OvPgWJfrRQZ8TXfRM7Wkjqs0N2J2pyRMq+uiUvp2z3ON/ErjHC0iOAd4hEbJY6Up2ABd+GiZEr2goZwy40StVW7dRn2H4t9Bb0YmPTAfAeuSAdfgf5JT5hgXihrXoNO63pbiP8RhrbOY01nWy4xfcp5oJ0Kj4XSA3YflpwbE3+dx9BwiQ7C8bw6UsY5EYrKM2OJMzzaz89L5qTtq0WUlxRco4bEL3cX0xVRIiSjua/uvyHQOqyqMnZZ9drvRi+OPQmUNf0wo07FcktPhUl2nDmIMHT6mSZiTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=E+qpiYl1; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=E+qpiYl1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPMM24C0Bz2xlj
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 09:50:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1794351052;
	bh=eh/GkHmVLemeAYxVqb0jIsD7IgzOXsSMzWc10IqxN3I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=E+qpiYl1HOD2n9wrp4FO84c+BjljBtMQb7NsJBaKScfSXcm2erLdY9zpRR6YavS3n
	 x9kIFzMpd1rTmVNGTYH2TqyRBrr2YjgbM6keWHhJIUKMnyigds97WQ6132sUCPBOqM
	 0wvIkEA1Dvver+LehqYg8TfnwY5hn3KpeellgANrWVOzW2rLbwg0hDKlIsQa0aloXM
	 B5FYwyy8Ut+iTpcSHEARU8Xvx68/Jk1wO0XV0PCtfdTgM+Mny3pgIhE0Yv4y0ql3Gd
	 GvMGTbvpoBaGmhZCMlgGF9c1hGx63RTRPBe42OUK9hEVcVv9IYTgQ63OHGeP0S80mE
	 1agYmbUOrLgbg==
Received: from [127.0.1.1] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D4F6D70885;
	Wed, 11 Nov 2026 06:50:50 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Zev Weiss <zev@bewilderbeest.net>, Tan Siewert <tan@siewert.io>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260816-ts-x470d4u-v4-0-cd08e78287ec@siewert.io>
References: <20260816-ts-x470d4u-v4-0-cd08e78287ec@siewert.io>
Subject: Re: [PATCH v4 0/2] ARM: dts: aspeed: ASRock Rack X470D4U BMC
 support
Message-Id: <179435104820.1995370.12519686770871849197.b4-ty@b4>
Date: Wed, 11 Nov 2026 09:20:48 +1030
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 16 Aug 2026 13:05:48 +0200, Tan Siewert wrote:
> This series adds support for the BMC of the ASRock Rack X470D4U mainboard,
> which uses an ASPEED AST2500.
> 
> The mainboard exists in three known flavors, the "normal" X470D4U, the
> X470D4U2-2T (with 2x10G RJ45) and the X470D4U2/1N1 (an ODM version with
> 2x1G RJ45 that is now available in retail). The 1N1 version also has a 64MB
> BMC SPI by default, but they are all swappable.
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


