Return-Path: <linux-aspeed+bounces-589-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F763C02190
	for <linux-aspeed@archiver.kernel.org>; Fri, 31 Jan 2025 05:23:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ykknk5NrFz2yn9;
	Fri, 31 Jan 2025 16:23:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738301018;
	cv=none; b=bM9xJBXEHJfDrlcOI9E64m0MNhOLlTHKzii6F94gTtxKzwFX8KbP1IgPjFsmd4mSUF1z1DT+FGbfkabte4AN7G45c9OKcukwmpJnVvrAZtCY1aANP5ZvVH8OpKVDoaus8Dl0UkNO0QrB6SAk8iuJVsdMfE8m+3iKMNjedxabcv6iBcJ6if+jCC85nyf0YgkRjg1SuKqMFunYUjQ7LwjcnqBvmf7B4v9mzl5IK/w3C2QQdyAisOuaW/ydq8GxJ8FhfaMDdAnJTBhqxgb2BwNvSloOdIlV6NmvMpLTMheOE0VMW7WXLIoctYG0+YlTj0kdZsqXiwiMim4QJ/QZ1VPdkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738301018; c=relaxed/relaxed;
	bh=nHzzpFNmIfwWdlNXYyTx0iN7gtiOz4Jj1PJOMYHhhLI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EFttyxuv6fKF7z4Em9mpt/rhhgthIzaqa37fZmEBdraJ511aOAh0/FC2L1t5k867u/z4UxTKNXfTXZ4kmmQNsMIeIz94LsgH1DXKSKEmPvwzTSw7YSOX7MrWUVzVzK2sSOUxeFLwXpBl3XYlm7+fCrqS1a4FBcUxnODljs7SyHIcTQj5nrvrQ1ZBBSyMt8JwoztiX/SZyNNLWGRi6j9uv9hl/voS1Kak4aTYRrzbu2vmgIxJnCZOC1bBSbC9Su3TqGb222+IIvKf1Ljo/fDyu0/IjGqqocxA3KGQBj0stlX1LurKvdU0enqveqQ1Q7n4SuOQ4qo4ZdGLPUCe8EJB6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LF+vZ1T/; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LF+vZ1T/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ykknj3vR0z2yMF
	for <linux-aspeed@lists.ozlabs.org>; Fri, 31 Jan 2025 16:23:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738301016;
	bh=nHzzpFNmIfwWdlNXYyTx0iN7gtiOz4Jj1PJOMYHhhLI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=LF+vZ1T/ZDcs6L36WCIVarRu4CvhnOcCgHa6gtqNOQE8Ky+De6rWDcomVCauqHenr
	 pkWATCkD1EcEKItAiBu+WfRiKmacMuOUddotmMn1znrwT7rbCosVoHVn0ENhMsqiyk
	 ilo+8Lrkj75Rp/IgscW+kRlQusQoCjnbobzl6TOmBGTcnp+0MLSKNYDjwOp6CnaegA
	 8moI301FtJieCFeMKA0rzympQE/b6EZyRL0s9lcEpstwqcHFRGjeh5m6Wc5h4S+Pq9
	 4hlPmzr3HSsA/TBMRx9oB3+lWHQGJbOLGS2t3zdTJhgMkNT68Sl1/FoIVwoBXFkU8f
	 r3jNVrNCJwBHA==
Received: from [127.0.1.1] (ppp118-210-186-162.adl-adc-lon-bras34.tpg.internode.on.net [118.210.186.162])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DC97171747;
	Fri, 31 Jan 2025 13:23:34 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Joel Stanley <joel@jms.id.au>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 devicetree@vger.kernel.org, Andrew Geissler <geissonator@yahoo.com>
In-Reply-To: <20250115112239.430636-1-joel@jms.id.au>
References: <20250115112239.430636-1-joel@jms.id.au>
Subject: Re: [PATCH] ARM: dts: aspeed: Remove swift machine
Message-Id: <173830101484.93883.6382944476465968904.b4-ty@codeconstruct.com.au>
Date: Fri, 31 Jan 2025 15:53:34 +1030
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
X-Mailer: b4 0.14.2

On Wed, 15 Jan 2025 21:52:38 +1030, Joel Stanley wrote:
> This machine is no longer in use, and support was deleted from openbmc
> in March 2022.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


