Return-Path: <linux-aspeed+bounces-100-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38245D5D699
	for <linux-aspeed@archiver.kernel.org>; Thu,  7 Nov 2024 23:28:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkytL5p0Fz3bmY;
	Fri,  8 Nov 2024 10:28:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731022090;
	cv=none; b=Q4ZFXAOf1jkGSPfXmpmlRP6D5aeHOhmfyAf1N3/fmCA5fbseLB0MDTWPCAks53yIA1XrzmUhFKlTtTM1go9qLbbEDLizpCbfKmenegNrtKigbSfPe8iWNIczlw+Rna3EHKa9mA2bHf3ErtGLj7rrBBZ2litLZGLjEjREzsb69lFBsbpUvUHKGvfMfIl5GzW5zN5fXNhAMPqOSbym769dVi+dVIjAPKfWUDxYCSHhryqeCUTvYXqP8ltcbZAhOXgCumoZo69c44hi1UXanuBYtbSVg43w9LKcFLfeh3zkekcXWXmRQOmlrii1d3emKZ8mz4qXp6aUcwIVXp0C1ODbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731022090; c=relaxed/relaxed;
	bh=ZJ40w8yoexDu5E/YyKd7BvJVrxVO/pnmp4Ow30xeJfs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KYLeDeuo+10P6uLd/SUsVmfqDTBi0+39+GWQ8R39HIfWGQCqW9gBXeFpvD3G2L6zzdSf/a4BI+m8+d2QMDfTukb+RABqo70Z9Kc7cdQfPVd24WamCdwxof9e/eBmXMO/IFfkYkxW62/3RnXVrsXar8Ur0ImpEK/G/9IRRvX4dXpy1ROOjkd8ouPuSiWmtHJalymoermXDuqDbCEY4WkpthHrk30vVzXpWyTq850qNwvOq7QBD5yEKavD0c3UPvxVMZXaFCZu/MXaVyzqvzpcsIw23Vl/9t6zEWIp2jDooUW9BQDJphyS7xW7lS/Q4UKm5DjhNIuPJ9A9nNGiS3lVjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=MOSEdpym; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=MOSEdpym;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkytK1FMtz2yVt
	for <linux-aspeed@lists.ozlabs.org>; Fri,  8 Nov 2024 10:28:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731022087;
	bh=ZJ40w8yoexDu5E/YyKd7BvJVrxVO/pnmp4Ow30xeJfs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MOSEdpym3cSejj1E/WLUhFEjkDRfBaivraKLu6SIkw2ly59Jk9vd2lcwz5WfiesyI
	 kgXCVOJWS3wuABPftJ5IP6dzHu++1hOo0jozIOHjCOXRyEhOH9nCg+Z+020e3Oz6iI
	 rvxAQiwdowwjbzpc2mQZBIFBtDRoQHl+YQcW7pOwfoPLPickUcc/Jjh1fSo6a5PAKq
	 SwZ25Si9mle0xl2cXhOFgPEyvEvzGA0e0WR9nUXrCsIKcP6B9G2ueS+8oJB4F7IPGU
	 1Vi/csvgnVJ9olAruS/HdZPSNK39RBxQ8+l1Oq+HU6Xt36Roi1JJh1H7d6Bix45MEj
	 MXYhWH/Q9OXHA==
Received: from [127.0.1.1] (ppp118-210-167-185.adl-adc-lon-bras34.tpg.internode.on.net [118.210.167.185])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7CAD16B9FA;
	Fri,  8 Nov 2024 07:28:05 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: linux-aspeed@lists.ozlabs.org, Eddie James <eajames@linux.ibm.com>
Cc: joel@jms.id.au, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241107151431.1045102-1-eajames@linux.ibm.com>
References: <20241107151431.1045102-1-eajames@linux.ibm.com>
Subject: Re: [PATCH] arm: dts: aspeed: Blueridge and Fuji: Fix LED node
 names
Message-Id: <173102208534.28952.3883977704243650358.b4-ty@codeconstruct.com.au>
Date: Fri, 08 Nov 2024 09:58:05 +1030
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Thu, 07 Nov 2024 09:14:31 -0600, Eddie James wrote:
> The addressing on PCA LED nodes should be in hexadecimal, not
> decimal.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


