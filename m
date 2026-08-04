Return-Path: <linux-aspeed+bounces-4607-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0ED3C55184
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Aug 2026 13:26:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDvTG3JhRz2yLY;
	Tue, 04 Aug 2026 23:26:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785850002;
	cv=none; b=Vn4EiwHXWRUAoJ8E4O+gXyJh2w4NnEfsJ9Gqa2OGtGzH6wssfYhP7IBVFtCAlnDCmCNhOx2lipLj0WweLTkAcDuomVI8fQvGKGv/hoVRzUebwAcMnaWRMNK8pZXBCwCmRNz6UPbXTQQzgGLSv1zramzQMELy79eKewkrcFWkbo02P/Gs/aqnHvNgbcNrDFa394xYVWnnjNgXbnBLPdZw86GuRjYiQa2jkbOHQ3j+pUoZuBGRbUpajB+1UBU7C+tfXUxqJMo60Ug8pDz0rQqdPM3LZAu7AD7zy6QNMUxaqdK5AW/J+Nta1VV6vvuCmwp6yphVq6yFJVcrR1OKSWHJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785850002; c=relaxed/relaxed;
	bh=mozmpqxreYt7kfWXg/1a/5py6oUvYOv4Rfa/YPbStmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxO8SGOCAByptaix6Z1IYtw4ats0SHglvrv+sQrYQwB8rBAjkygt7C+P6+2NcSZZxiUU04ygQczZ2j9wZE8g/VEZsg1Q8s6SmsSA05T5V+yl3kLCS9pLNDwgJT/iKgR0nVjr4mpVjenKKlIHqyoxRlDrtSPBspXUSebQNjrZV1C8Ca6cvknWHm3NFgZ8Jgd93VMJb1NWuV9WzJJW6cUUd2OcuUo3e2eZ/l8dZb2MA6EA5197qZno9TGs26YkOdxKEs0hotpaws0ZJTRHFY83RBeeLZrK58EwG3XXEJb3hAOk0ZCh26SknPtAcpn7Yd0gK4THpN1CZyJlbBRI27Z0cA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=npPVQA1N; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=npPVQA1N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDvTC5Ztqz2y1Y;
	Tue, 04 Aug 2026 23:26:39 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8EFF543AC4;
	Tue,  4 Aug 2026 13:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E307E1F00A3A;
	Tue,  4 Aug 2026 13:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785849993;
	bh=mozmpqxreYt7kfWXg/1a/5py6oUvYOv4Rfa/YPbStmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=npPVQA1NPT3z3In8PEI4GA24tKxI4vrxoDN8lFrWQ8JbTz0eFtjO5YVTPs75yOamX
	 wH8a+1ILRGn4sQ3WReFTVZetBWeBlGJHy5cL4YW928zyQMgfPghenIVS9SCU6CiLfF
	 jave392O/lw+ZhPcq4aKXqfYAHYNof5Nwb9x/4/Q=
Date: Tue, 4 Aug 2026 15:26:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org,
	linux-spi@vger.kernel.org, akshata.mukundshetty@amd.com,
	bleung@chromium.org, groeck@chromium.org,
	chrome-platform@lists.linux.dev, corbet@lwn.net,
	linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
	andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org
Subject: Re: [RFC PATCH 0/4] espi: introduce eSPI bus framework
Message-ID: <2026080449-festivity-computer-693f@gregkh>
References: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
 <2026080416-lagoon-delirium-8e84@gregkh>
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
In-Reply-To: <2026080416-lagoon-delirium-8e84@gregkh>

On Tue, Aug 04, 2026 at 02:18:42PM +0200, Greg KH wrote:
> On Tue, Aug 04, 2026 at 05:22:55PM +0530, Krishnamoorthi M wrote:
> >   4. Naming and structure of the public API in include/linux/espi/espi.h.
> 
> What specifically are you asking for for this?  Do you have userspace
> code you want to integrate, if so, does it work with this?  And where
> does it live?

Oops, sorry, I thought this was uapi stuff, nevermind...

greg "i need more coffee" k-h

