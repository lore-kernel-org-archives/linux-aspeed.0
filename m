Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E937606B99C
	for <linux-aspeed@archiver.kernel.org>; Fri, 20 Nov 2026 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vzLzVcrk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWH4c2gy4z2xpt;
	Sat, 21 Nov 2026 00:58:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795183136;
	cv=none; b=J/eA8/Tnln1KB6H9+i6sCmEgEctxgT+yH84R1iHSo09Aq/ra/RCi+jOx1xTv3hp6dao3wMZ9gTafXeUYRKrWDn2NC9R1aBWOa4JlPD9+K8ZE85MGj/Y4ELi5K/TC097YjqZ+EkKAe+c5sq2PgJ0+U5qxL8sJt1/bpVVfnUDzVsjTpxnGM8iYiVNRQthfo2ZKTLIU5b6gUzcJ0jllyslaxsQBDrQ7Mq95U2rUC/tj/hsxK87vRnRpJWXAg+ZQlHakb+8/2O3JXxVVckJEwTXqOZwoLLYEnHfrCxnJdHWvPUyAsHhUiDCQMJuWXZMjNGo1zZ7UJOBpbT5iSUz6j0YkBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795183136; c=relaxed/relaxed;
	bh=nNheUa0aYoRrQSBs16Ly36vY+3Ibo/k8RtKCduo70eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsSUBAY/LtEIIy5jGKM438dZxZYWxUsFVEEyZFW6hvqz23GBNLAS8oAqCO8Nnr8optYyLmatdiLaFbrwcWDzsmpTo4oejdPHu2KfpLjk/lECFF2Coq+MRKfrOSWHgMQ/qyDLn9MLWIukJvdwgHJJKoEra4XK522NIFmV4wc/Ahzqad2RsLRRblCsRG++oFwEE2k+lm74vfpEDi8xcuYR2S3YUh5Gs+dgPKENz5dq9tZdm5Z8HscBXF8H6pgDYYHBt6hApV9Nm+Siv4Url73/fz02T5l/Qhr38FbWYpYEbErNvayAMHzdSVu3ln/JXe9Uix8V41L+MI9Uy9HxPQJJSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vzLzVcrk; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vzLzVcrk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWH4Z5sVFz2xmh
	for <linux-aspeed@lists.ozlabs.org>; Sat, 21 Nov 2026 00:58:54 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 439FF612ED;
	Fri, 20 Nov 2026 13:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E0D1F000F2;
	Fri, 20 Nov 2026 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795183130;
	bh=nNheUa0aYoRrQSBs16Ly36vY+3Ibo/k8RtKCduo70eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vzLzVcrkQkW8KqnstggvnCieEbDhso7NW8M2zqgheGDAxyV/1Usl/J+PoWc7iibdm
	 aVj/snRnvwIV/zSux9brN6ip4+7jVECm1D2Nv6gk034HXc10ujRQjs8PhDlH2OmJgz
	 vKfnMk2OIE5u6GUEy3tN2vVyYtx0cHjX/i6QFj8A=
Date: Fri, 20 Nov 2026 14:58:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Liu Chao <liuc63@xiaopeng.com>
Cc: neal_liu@aspeedtech.com, joel@jms.id.au, andrew@codeconstruct.com.au,
	ryan_chen@aspeedtech.com, billy_tsai@aspeedtech.com,
	linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, liuwb@xiaopeng.com
Subject: Re: [PATCH] usb: gadget: aspeed: clamp transfer length in RX
 completion handlers
Message-ID: <2026112035-syrup-universe-504f@gregkh>
References: <20260917103205.3049861-1-liuc63@xiaopeng.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917103205.3049861-1-liuc63@xiaopeng.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Sep 17, 2026 at 06:32:04PM +0800, Liu Chao wrote:
> ast_udc_ep0_out(), ast_udc_epn_handle() and ast_udc_epn_handle_desc()
> read the received byte count from hardware registers and add it to
> req->req.actual without clamping against the remaining buffer space
> (req->req.length - req->req.actual).
> 
> When actual reaches or exceeds length, the subsequent DMA has already
> written past the end of the request buffer.  Across multiple short
> packets the overrun grows with each completion.
> 
> A malicious or malfunctioning USB host can exploit this to trigger a
> heap buffer overflow in any gadget function (e.g. f_mass_storage,
> f_fs) layered on top of this UDC.

We trust the hardware here, so how can this happen?

