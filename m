Return-Path: <linux-aspeed+bounces-541-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179F8C02182
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jan 2025 23:31:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YdgLv0wb5z2yQL;
	Thu, 23 Jan 2025 10:31:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737514113;
	cv=none; b=BZZqZ/MxqE6y8odP+KKcRWHCcQWEnL+4yS8UD2WPa3Dl57B/UZLsyTnHUTadn+UVCZUnyHZEa5IvdaPPgTYsIo0T6gHiqjzIbt6Il5XcSulRk1XGR6d8axMTbWsdE3O7SQ8jbR+704XzfZdA5HDc+6qs9r8UmfoIDm7fVmNskLUibM70zw6I+cVGGtCw5sjlXIM+A0F5fbr7W8c3T9CxZbEe8pPnEITasEPG6Rk1arQ1g8Y0tjejt0uk/GQZyJ5OHHIsIXgUClXcSM3Ky2K72v3pK8BBGdr0VhyPTXX02nF095qN+C9K7MaQy+3gG6CBlMeG+WxJWflmeqsa0zi3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737514113; c=relaxed/relaxed;
	bh=5yBT85ljG1wrfV6S+5drF9x61f+zj54LsDIH5RHI2Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8Cmisn9yq3VIqPK3jmttggmDO7HYjcSseqTcmehGercyXK6g77Su3hERuQ3N2B4PdyBBJs2euKkerDGl0zPrR+K33MlRwrinwgtN0IUBEbeYbbUVqXGaznyuaovy3kv/fzryu0YQsgkrxE4C52iM4VFtRnzFFLH2aE7Gpl1/3TlD/U+WUzhuhHvWokX2Ji8mLOjU3b4tIIm4oEddeD7TLCGlVrEPdd58TtRzBtK6d/LmWpimqEBK7rCOAha2uqD8QOnroAYqpEUWs4bIsWIQBo8Sr5oFqGN7JeGqGbXEZRbtl2TOZOgnyONodpl1bjTZlnzXAoSMbIVw00pPvPmWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DjV9xUi3; dkim-atps=neutral; spf=pass (client-ip=220.197.31.2; helo=m16.mail.163.com; envelope-from=oushixiong1025@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DjV9xUi3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.2; helo=m16.mail.163.com; envelope-from=oushixiong1025@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 68168 seconds by postgrey-1.37 at boromir; Wed, 22 Jan 2025 13:48:31 AEDT
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yd7mv1YF8z2xHT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jan 2025 13:48:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=5yBT85ljG1wrfV6S+5drF9x61f+zj54LsDIH5RHI2Yg=;
	b=DjV9xUi3F6BvtjRuZE3J9ks4LoIiE2H4D1xFGx9byXRRYU+P5Oc5C4cFywYPp7
	3d47k7x3bwimjr3CxwNHSIWpGmdEFnTlBQGrDVMTtp76B89+kQkoe/r2ggB5gIPu
	gNNQaE8TvGHdSGdCVrGx5w0iHwifoKJHBC3s8POakh1mI=
Received: from [10.42.20.80] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAnej0CXJBn0GgDHw--.39692S2;
	Wed, 22 Jan 2025 10:46:27 +0800 (CST)
Message-ID: <42a2e30f-ce1a-19ae-6886-f11a8a58eea3@163.com>
Date: Wed, 22 Jan 2025 10:46:25 +0800
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
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/aspeed: Use devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Joel Stanley <joel@jms.id.au>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, linux-aspeed@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
References: <20250121075041.201599-1-oushixiong1025@163.com>
 <b5rhfo6q6ko4vf2vubkcma4v7dnpxruh7peyqav6tszj4sg6ee@mzjc543jsujn>
From: Shixiong Ou <oushixiong1025@163.com>
In-Reply-To: <b5rhfo6q6ko4vf2vubkcma4v7dnpxruh7peyqav6tszj4sg6ee@mzjc543jsujn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnej0CXJBn0GgDHw--.39692S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUjku4DUUUU
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXQfbD2ePkETEKwABsc


在 2025/1/21 18:16, Dmitry Baryshkov 写道:
> On Tue, Jan 21, 2025 at 03:50:41PM +0800, oushixiong1025@163.com wrote:
>> From: Shixiong Ou <oushixiong@kylinos.cn>
>>
> Missing commit message
I will add commit message on v2, thanks.
>> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> This doesn't match your email address, so SoB is missing.

The SMAP service for my email <oushixiong@kylinos.cn>  is not working 
now, so I sent this patch from my alternate mailbox.

Shixiong Ou <oushixiong@kylinos.cn> and Shixiong Ou 
<oushixiong1025@163.com> are both my email addresses.


