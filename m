Return-Path: <linux-aspeed+bounces-1433-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193CFC61DB2
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Jun 2025 05:19:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJSQ25j9Kz2yb9;
	Fri, 13 Jun 2025 15:19:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749791994;
	cv=none; b=nWp4WYTcuL6j5kfaiNIjXAxwKiaAunEGdKAL5qEnc/6jxwKDYZ8qO0RFaly41SzfwS80SV+S6a3a707f/bL825DgMi/L8aJnJBbbzAwOYvOU8OIum9ryXg2MrsYXqCs2IsHFIQjSwMoL94gjCJNfvgwpCxEOGEJZjBrJ5Snk5wRWtn1KHbDdhHvm4A4EBzqEgwKUTRksEoemrX20IZNDEp6t6lXAG1UkTnAmzmjZqYLb0BxTjSlLUcsZbxxc9GxbfZ7PuZ9bCV1j2KQr5JPcpYPUuJzN75QOyKTLJG79mWqv7DHb/bD9x1R7azUp88s1+Lby5tr3hQ6wed1M8K91nA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749791994; c=relaxed/relaxed;
	bh=j9lhSwodmqSZLtijyE0pSLrkjXtCG6UQNDWeeUmgbW8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OSLMzeQy6xF96WCpu1ruOi3UdpD1HjiiNfNzqvy4zZZ8HpZWVsxH11SKgBKkoOtgFJrKBDsR6HPw3bGUTh8BoggZEeCw7Q5T7nWf36Pxac+QkPinuFR03VeYmnxrId0BWQAnWG3+1SeZ2HlwXv/hED7KmQge/1Qju+JahI0vv9wo1E4OG8pnZfSCoTBR56SMhihNH5W0KWjGY7uS5WIfeKF6XILW4WIUo3843TaGka1qqVA/aSpqPK5mtpIjxFGd//GZo6GyOb/HtISL87UzFiTYMOyLuKIyLDyA5uAqAqLVBOhyZoh5HPN9LrTy9tN3cSE98txUdAALAiFmsSH75g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=QvuINQWn; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=QvuINQWn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJSQ16x6pz2xBV
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Jun 2025 15:19:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1749791992;
	bh=j9lhSwodmqSZLtijyE0pSLrkjXtCG6UQNDWeeUmgbW8=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=QvuINQWnEYPzu6AiW//WC2jHdsSgWYaKlBuTLW6kwJTlFGj6iAGW8/qDn+talgmly
	 dkG5UehVSGzVgQZQbo5S0KuKFAPzBUsjt86qXJhkf1AHwPV5MPe9FXztTuQ0By/dRF
	 NlCWml1pUnYk+rXEuiYyg6or2JzFHmKKRNi3yzYcyf9DWCgMJkGZW2tnubQ6DEAXAt
	 iqXZQPeIi/euzBI7GXW7W/HbtudZoiWOrURkZSi2XnYvH3a9qt7mFALREivlMaQSkx
	 O1hOL74z78zGYghiRHkm3jlsWEBNypNMZT+Ioxxig9DZphR+NnWX+z/8Ly/F8ubc5r
	 dEuftikvGR4hQ==
Received: from [127.0.1.1] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5763A680F3;
	Fri, 13 Jun 2025 13:19:51 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Peter Yin <peteryin.openbmc@gmail.com>
In-Reply-To: <20250611080514.3123335-1-peteryin.openbmc@gmail.com>
References: <20250611080514.3123335-1-peteryin.openbmc@gmail.com>
Subject: Re: [PATCH v2 0/5] Revise Meta(Facebook) Harma BMC(AST2600)
Message-Id: <174979199120.342730.12220286428468673903.b4-ty@codeconstruct.com.au>
Date: Fri, 13 Jun 2025 14:49:51 +0930
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

On Wed, 11 Jun 2025 16:05:09 +0800, Peter Yin wrote:
> Summary:
> Revise linux device tree entry related to Meta(Facebook) Harma
> specific devices connected to BMC(AST2600) SoC.
> 
> Based on:
> https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> commit-id: cb3f397b17bbda3f2998eff9e54b040c8fa85cc9
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


