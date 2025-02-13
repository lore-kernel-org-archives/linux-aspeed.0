Return-Path: <linux-aspeed+bounces-708-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C60C021A0
	for <linux-aspeed@archiver.kernel.org>; Thu, 13 Feb 2025 07:49:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YtnQ22Fpxz30T6;
	Thu, 13 Feb 2025 18:49:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739432970;
	cv=none; b=YvokozIRTOcSq28D2NArsxudiHPLR2B9XmI0vljVs+/vz5TO8renT4eAbUeryYRaVR6OILdOOUDLrvjKW0/jzSa3eup81ab6xzfEtaXj/ded6xtwfQRMV+KfdYTKYUNWsjQkachQhBaD1fbGZaFKRjn/yzqb24nvwrhudSZkA1UC5nTnSn3uFrcarnia38ICo1NzdyHzw/RCwEV164X/v6WWH+ArVxnpZGgI0DBogP7TkCe9NYq9Gnd+jg1gqxYmsTvd30u1LnBEk81HInesVBbzEAjv4DXRPncAT+d+dnaNHA+6UhI6QyUrw8/AkHr/Im6vE4dkfZ2QDxwfCwsXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739432970; c=relaxed/relaxed;
	bh=t5SBHujVb6RtmGbKK+7MgKn+iTLkRwv9ntIAACittIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu6FqzylKS89xth2PUIvbPXTHXxfDt12f4eVJS2RSIwPeGk6qp20qbMRzJjUcbmUt/VgGT1bb0akQvVmMx11opINAJirsR7ptL80RKT+R8RM6lsLSG4VCuh0kUP0lBD+HTEyvfXQj/uBv3yiPbNmMCmovouWViuk/W54a7ifHXXgJsjKTwQ1xiv2FK4H+Kbiz87IL9kORuj0ObC4FCAzjcCoS4pjcbP8XyhMi75y4JWZqJtGgi5+/jQu+B7WZZaRpttrPLXnnxnVxgrcTeNSGPmeFqJSopQmSaFiMNDOUinImYNDtikQxDtldU0IZhFn7AQ5wHqtQY30PFa5geLXJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qMluKzxm; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qMluKzxm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YtnQ06WLkz305G;
	Thu, 13 Feb 2025 18:49:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AE923A41E97;
	Thu, 13 Feb 2025 07:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7596C4CED1;
	Thu, 13 Feb 2025 07:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739432965;
	bh=2r+iftouz+KNmWMr3hXVKgACN/Hfjh0z0QlWbmjE1h4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qMluKzxmo91HgIN1XqkBR3AF7NgltciJKCmluuhvjfPw7PanUY4Ka5mozmeVyD5kb
	 XhASNZQV3PF7zlpU4/W9nXn5/2hUbc0y8/yPTLKFbGPWRZe604hrBuY9RSRXb42L4w
	 tATww9srWEdEo/s3xQL0FdCoaUHGzZJBYR58r/eaBEZhz6HohlAuddG5xQR2vUr1+E
	 kMB4mFf0DYXi1IORBjBN1ysHl+A50TxsBym5CV7mYQujhqHGg71oN4/b/8cC3j0b3u
	 ki0MR2Oxvb+rgyz0IFScFso0vcPnscvYFgF/xV9AjcdxZTRTKilye+wBn2K1WIdbzm
	 dchmsnZ2sqvVg==
Date: Thu, 13 Feb 2025 08:49:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jammy Huang <jammy_huang@aspeedtech.com>
Cc: eajames@linux.ibm.com, mchehab@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au, 
	linux-media@vger.kernel.org, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] media: dt-bindings: aspeed,video-engine: Convert to
 json schema
Message-ID: <20250213-loose-positive-moth-be16ab@krzk-bin>
References: <20250213015338.3243171-1-jammy_huang@aspeedtech.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213015338.3243171-1-jammy_huang@aspeedtech.com>

On Thu, Feb 13, 2025 at 09:53:38AM +0800, Jammy Huang wrote:
> Convert aspeed-video.txt to yaml format.
> Update aspeed-video.txt to aspeed,video-engine.yaml in MAINTAINER file.
> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


