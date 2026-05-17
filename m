Return-Path: <linux-aspeed+bounces-4039-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE64CD4F21
	for <linux-aspeed@archiver.kernel.org>; Sun, 17 May 2026 14:21:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJNQb2DY5z2xdh;
	Mon, 18 May 2026 00:21:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779027671;
	cv=none; b=VsDPEaqDFpPrgN8antdsLUMwZjcN4bH+OwPQH03xSvgsmPY0nrUz7gH+CXk/kafBACYGnFOZ9CqpzRRct2jUite6jh5ert302L3IQGPr8glnPw0g4m1Iw7c+BSsJ0jr5dj7KrU2qcrVu52rtlUvl+2kiJvFn1aRDgqauGz59HLN+YXFojNtAhLlJ7tzTMC6twBZDUR8PMD1poCdCaki3JoYUyainRgyPOI6i2+7TkXpPwATF1pn5PdSYIXfOyP5bBV0i8gB1yunHcTyft3s+dVUGIkU8nqWTZiM5VbjOa/GdBF7fn9dQCBmGbP2X2QeGFGVhEhe2CpJDusdreH3tDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779027671; c=relaxed/relaxed;
	bh=oqRuIKKvAbmniJu6GGfOc7x36kGLyzQ0kjsPEDpVaBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kce4VdZqrsXzv668wilqBIq2qsjkHMM9Vpm3Su98GXvUJU2+heu3hkdBrIOTzJy+eDM49XIZZ25dTAB6DtLHVkOIikOGMrHm+7syIvIVCaeqN0s7y5537y7drrOF8XyzISIKL6d9fV+24a764WCR2swkj9tgpuWSRoTl8e5bs61ygh2SwDY73Q5QCz9iDPlvvSDXk0AMkiuZH9FMXrSZrxalJnCJjYh+zI8z/94IFJFZ7qy3TZBBz9D/DJXUy2EKoSlnUAVQev8ESKvZKDwY2pWFDGdST6LcrXKpO4ybUxwuMwB1KzF0Fxw82qP7H3DZsu4c6SuKKiV4XQgiTaYqcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OMJFwlTQ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OMJFwlTQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJNQZ1vlyz2xWP
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 00:21:09 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5927E60125;
	Sun, 17 May 2026 14:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B340CC2BCB0;
	Sun, 17 May 2026 14:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779027667;
	bh=oqRuIKKvAbmniJu6GGfOc7x36kGLyzQ0kjsPEDpVaBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OMJFwlTQzYuUBsbCWJJts/oXUhdym/cPjgxl6wEbtBsW9yRazf8SxZIiQBvyR/uAy
	 DLkOA0BuY6uSgFhkv6fx2OfYtD1em33KEwsxL7LnDxB4JUJaK3rp0c1HaNbdoMZRWO
	 mddNHDH0wcSfY0oJlaxF2I6QOmR1SprHwor47xyI=
Date: Sun, 17 May 2026 16:21:10 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Xie Maoyi <maoyi.xie@ntu.edu.sg>
Cc: "neal_liu@aspeedtech.com" <neal_liu@aspeedtech.com>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: usb: gadget: aspeed_udc: list iterator used after loop in
 ast_udc_ep_dequeue
Message-ID: <2026051752-passage-thinning-cc4d@gregkh>
References: <TYZPR01MB67588F1EEB07DBEB681AEE1ADC022@TYZPR01MB6758.apcprd01.prod.exchangelabs.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR01MB67588F1EEB07DBEB681AEE1ADC022@TYZPR01MB6758.apcprd01.prod.exchangelabs.com>

On Sun, May 17, 2026 at 02:03:47PM +0000, Xie Maoyi wrote:
> CONFIDENTIALITY: This email is intended solely for the person(s) named and may be confidential and/or privileged. If you are not the intended recipient, please delete it, notify us and do not copy, use, or disclose its contents.

Now deleted.

