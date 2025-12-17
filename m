Return-Path: <linux-aspeed+bounces-3133-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46C2D64090
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Dec 2025 08:31:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dWRpZ3pTMz2ykV;
	Wed, 17 Dec 2025 19:31:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765960278;
	cv=none; b=Ijx6+fiIViVP20wQDJ110BEVMnjwjecabMtrKxYAGRyg/L4iqfXLbDAmBA+Twtd2xp4MediEmOHwcdkJmSI1f24Ag2SlpSR4r6krtE1kSqIjNZXgZwV/KS0nefL9zyNRgJSfaGcpNu4L9l6jSVTQ0WGPfTqAzujqcPq3m1dqCurPxc8D4Nh2myIV8CGAWYPMGQkZwTMOoCyBF9o3FOtRpKWksSbwwoTieWREF44QSwbtTi5SgoddIef+56U/xnzlR/NsnEu9AlAv6Tt7BHaeOr/3Y6wT6cC+dCDPaokJ8IXj2Rh3FoWLH4oip1A6ilUrs8iy5T1/wyM5WhvSd+Po7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765960278; c=relaxed/relaxed;
	bh=1wYrbfZXZh7/scKLy3xbaCZxrm00VHqIIzOcEqNZUpE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SHHf0QTWXIvcxC7dw2+HDfFNKIP/3iov0VWZwPPuEb3Li9uKQs5/xEXURJ2BhMXjfQX/oP69GtwJ93ADKquvGwA+wNC+HZLSUCb+Q0eSflCFbzvH64CIzwtV2K/sqnk/uebFKABuXgstlXusIW8hPyR8BGFEeyk+U6Ankio3xao0NLuxyvLNQa2oFGLbzf412IrYzxESaPlc9uZIglfru5Y02o5fK40zuBAQhcZvF+a+0whdTLzw4X5KuSMoBGlIljEJsRZqfHiQCVeSD+Hmv1NJSEdIq8gwqiQmo07RgkA5Mr4A+kT6mIuykdFbVvMJ0D58av68VyGDvGiB7RobaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=X2Kg35ig; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=X2Kg35ig;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dWRpX6R79z2yjp
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Dec 2025 19:31:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1765960275;
	bh=1wYrbfZXZh7/scKLy3xbaCZxrm00VHqIIzOcEqNZUpE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=X2Kg35igSxKpsjL8aK8/Htu0f0qjfdhWw8i6M6+waNxAEC2djTGcmXwTZvwbPB72N
	 Tr9HGIuY9zdCTpouj4IMDAiYBToAFU6N48x9o77txNHsdsb7gtFUPOEglcL2FjLDDF
	 U4afLnP6sr1oNFg4g5Y+xqg7SnXNSpbOLcyd76DSSSZBIx2NQV5CebAH3rgg6tz0D4
	 93uuyUDsGowxvqPVaAveI5knAey1SaG/ni6LQa//yuhbn8aSqT0zoG/c+gm6Z9ekI7
	 4lVSgVtpLxHaBkDhyzPd3+6KwmhUZAg+JepV6tEFt1kduAaVIigUm6icz1w+sv/acz
	 ReR/yJ0lHlj/Q==
Received: from [127.0.1.1] (unknown [180.150.112.216])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6C1337DEAD;
	Wed, 17 Dec 2025 16:31:15 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 joel@jms.id.au, Cosmo Chou <chou.cosmo@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 cosmo.chou@quantatw.com
In-Reply-To: <20251217023938.445721-1-chou.cosmo@gmail.com>
References: <20251217023938.445721-1-chou.cosmo@gmail.com>
Subject: Re: [PATCH v2 0/5] ARM: dts: aspeed: bletchley: Fix dt-schema
 warnings
Message-Id: <176596027534.2875246.12913980516498879452.b4-ty@codeconstruct.com.au>
Date: Wed, 17 Dec 2025 19:01:15 +1030
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
X-Mailer: b4 0.14.3

On Wed, 17 Dec 2025 10:39:33 +0800, Cosmo Chou wrote:
> This series fixes dt-schema validation warnings by using generic node
> names, correcting GPIO property suffixes, and removing unsupported
> properties. No functional changes.
> 
> Changes in v2:
> - Split single patch into 5 separate patches by change type
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


