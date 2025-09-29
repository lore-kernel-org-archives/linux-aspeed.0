Return-Path: <linux-aspeed+bounces-2354-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03ECACAC5B0
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Sep 2025 03:07:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cZmMP2cZ6z30MY;
	Mon, 29 Sep 2025 13:07:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759115249;
	cv=none; b=eojeE8ZdL5DJ/1qMCHh3w/VcmBK5OAwKwZAQ38F7Pp75RnWU2OEArS68E2Trb4yS7s3b1UkyLMhw+W3zn7FOfFiKY5opeSkb5A088pkxWcFm33ZX9oWQ1lUdbqk09AuceoI/xFPBTLNXT/hFJEN5hLgK5Gn17RvzgP7odH7Y16E10WFAZEkmmMyqAGs407KBSPbI3UYapd4nPAj9v8d3wKgy7SL9XYlx/tsTKtxplyTlMD6osnkIMmXM5javU5TixqkI9sBo7ejfGVkx7yf8PlGvlXWcsmiJYrJZlMAvtg+8N0RBEdOKF7oBLxDgLF/EGQH4RMrO5+CgEM/0IcBSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759115249; c=relaxed/relaxed;
	bh=koAfHQgZNFwz/G/RE/7xAxl1N8KZz53PEKfz4qKLMuY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kEiXAQ9j2znnMv9BhCGgoPaxtETIvod6GX7cuZ+rNg8PGr9/7DG+19YRrOOCSJNj/I4y/8Ky+AzO9Tt/xs+RTGr6h8ThSonGZb+q3OlZUsrM3BSHUZ+3pT+bJXUDGXohzbsyXurhzgWG9kZhNBMOkLGIsD/nWjsRXVH6LU4MMSAvP3gUjICc294ZaBXjhr/oQN04/PLwmkZOOcSq6gbhotISAJHj1l0HuoRCM0H42l+Jf1RxAoLNeplV7Wa3y+7l4huU+SUgh5awIIPc30clQm6wzPKQEzU4MtFkYMOQbl/rGXuRS7hGlUai7UuvcyF3fhxX+a9t8eqyzFLpfAkpIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Kmlp1YXX; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Kmlp1YXX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cZmMN4mb0z2yrW
	for <linux-aspeed@lists.ozlabs.org>; Mon, 29 Sep 2025 13:07:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1759115248;
	bh=koAfHQgZNFwz/G/RE/7xAxl1N8KZz53PEKfz4qKLMuY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Kmlp1YXXAOz/7ZGIW9e0lQD8xPI5hP+N/TxvRozjHOWeSUmUdTz1SFujfPG4e12q5
	 pxh9Krxelay0STWxI5Xn88h4nZHknyAI8gfvWeUl7Qbs9JSrKTLHPcWm6aDnqel7mA
	 aiEA7ln5lGE3IWDvBdK1K+NNiWoebrRmLK36jebtxEd9Tick2WcVIJxGdpS7dN34V+
	 mHL9MClCiqRN7rTxu6c/OmJo2JeSL8OBF0mx9NRXhUa17BrUtUnfkULtKWAXwygyfq
	 gCrcBGBCahkJXCl/Yq3C0pUHQFm1NU+4/DfG+EgX9DcmwXXzwlypcMFM+PN2UVjSzd
	 VJyqbGWPHVSdA==
Received: from [127.0.1.1] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 88D5164782;
	Mon, 29 Sep 2025 11:07:27 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 joel@jms.id.au, Daniel Hsu <d486250@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Daniel Hsu <Daniel-Hsu@quantatw.com>
In-Reply-To: <20250926025952.3098933-1-Daniel-Hsu@quantatw.com>
References: <20250926025952.3098933-1-Daniel-Hsu@quantatw.com>
Subject: Re: [PATCH v1] ARM: dts: aspeed: harma: Add MCTP I2C controller
 node
Message-Id: <175911524746.2942521.16055072946484139660.b4-ty@codeconstruct.com.au>
Date: Mon, 29 Sep 2025 12:37:27 +0930
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 26 Sep 2025 10:59:52 +0800, Daniel Hsu wrote:
> The Facebook Harma BMC uses I2C1 as an MCTP (Management Component
> Transport Protocol) bus. This patch enables the controller by
> adding the `mctp-i2c-controller` node under I2C1, with multi-master
> support.
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


