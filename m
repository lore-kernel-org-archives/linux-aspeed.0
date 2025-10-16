Return-Path: <linux-aspeed+bounces-2480-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EC0CCD199
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Oct 2025 22:36:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnjV12k5Jz3cYg;
	Fri, 17 Oct 2025 09:36:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760631127;
	cv=none; b=HLC3VMJ3tcRb9lYGDBXnCMkSLFWrt65Di6v0/FZz3TRPsb+A3WVZOkJA6/cVopP7J86KeEx4GhmNVXJVDEznnzABWTGWbO5/vt4r3qmheltqkUWlqKpImWNRtf/fpuhmOlIYD6lilezVpe7lgqWDVQir1LXIW2wZRPN3eR8bnIPe7oBojGXSj5z97GCoKq6XUJaJtCifL8Aqw5W9TT76g47T4mz+oxDqGlGJmqiv7VAHKqpPTq1HUczJ/mm+cQTiXPcU+SxS1EInR54JkqRaPL8MrdiPi63uo2NlR7HDAu1Xotq3mZ32XBZmnI2s4el3euCkXHsMG+KTtW8HOZR+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760631127; c=relaxed/relaxed;
	bh=ACAqVbHWeoat6K3HL1ahrRzqT6qreY6/QV4aq1RfvOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=e12pxwc2eurNz8CbiVOFhZCHVrW5wgLA6Es8eYFq2ToMilNcJflUpdkLlt0F/lAfbGOvUQZhfPxuy/SiE72ZyViqRU6u0qAgM4grrVdPb2JUhj6CJ2LIxx1koRQrYAJK2TCLnscwly6qG3+X+fzQ4x5akD+93hCuwpKfyoktECish5bEapUaUb02MaHx7v4cgW3PPlWGxHWsvPJ742PrgGe3YS0Dn1jkDakHnIVN1PhcVjAZIqm8SDIQV+FXckGELLBpvcO8JOaYFfOYOz3AZ0puVJT0H/Nm25tBMGXh6+uzr8uWh/msS7GBA2UsQWcoOLEEJspvzfLIZux2Knxsng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W77zh9SV; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zoj5S0Q3; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W77zh9SV;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zoj5S0Q3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnXyt6S0Zz2yN2
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 03:12:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760631119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ACAqVbHWeoat6K3HL1ahrRzqT6qreY6/QV4aq1RfvOI=;
	b=W77zh9SVR+LFj2IXO697t8vf9ClY8nXFWdBSQhalgak0/Y8FPDgj1Uc9PellXXaDcGQ/xJ
	eS5qZqSam2zLgQjBPAHU5Y80kRAAYjZmeajJa3K1+Zsc/LVlrHx7KUQq4HTfQ6SnqR3uB9
	2NgM1eJPXyDb2iMAmM8In02L572g/Gc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760631120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ACAqVbHWeoat6K3HL1ahrRzqT6qreY6/QV4aq1RfvOI=;
	b=Zoj5S0Q34VyOgIAaFvUyYnWRIZEMRtrLFuyN1Gd34QG03facRFo3xGS1rYDo7OR0307oOi
	+miaKSZ9PdLns5vY6LeimQDkbARcA9TqlC83WOIyX3O3FaEm5TYqR+UUHwMs8CCgf+oHk5
	4siVgUanGEJIuqnDYJqDR9VyYia8wWw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-b_v_---INK-L7Ip_LenHIw-1; Thu, 16 Oct 2025 12:11:58 -0400
X-MC-Unique: b_v_---INK-L7Ip_LenHIw-1
X-Mimecast-MFC-AGG-ID: b_v_---INK-L7Ip_LenHIw_1760631117
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-79a3c16b276so28209046d6.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Oct 2025 09:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760631117; x=1761235917;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACAqVbHWeoat6K3HL1ahrRzqT6qreY6/QV4aq1RfvOI=;
        b=vmQM3ms8zeIOj2iMHmX+wwzN/cLxZ+u+JYWcrJM2mjgX99fmAQ0gJ5gi2qrwCMAtqy
         SerT2sk4Fy35q0e+XEQSoMYFff2QR+PmgJZbrrg65nKlPSqHTW7g7gszAS2q4lGxUKX4
         iT9GEOUbYAmgXeSogHvzK8QrHNML6SfAFxyHVEpVoZ51ePZ5tHtnkknUe/tT9j9RDW2O
         ijocas5JwnpP8mz1AoepdTtAyBjLL58aoI03dpOxy0aZO+TX9PRHrFK6x/5Mmjcq0HXt
         ItawB8OJNygo3xSTXzHwE0mS90VlbWAICp+9Bd/yqAv6XGTU/RBMs8ykvHNrCxnaMDQH
         8PMw==
X-Forwarded-Encrypted: i=1; AJvYcCWwL5FSNro8Os7Djj7AULrA0w6vCHHkQacGVK2qjUvocExxtaMUxKlEUsgo6qTRMh1uDnil6s6bkG2Q4l8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx+7YL6PEd7e2hTIpNvQvv/9diOo8mKwt0xTAf1N1cJVGuJwO2D
	MZW9DDx8hYNjX+0IQbR+T7RqKUooFROp1EInFDf0EezpS06whJMjrmq5tQ/KM/8EPxmNlusEzEP
	5Gp2iitb0A+0KJYxF8JWvwdWNT6cLCvl0QVbwmW/iYNM+0y5GCmkFya+Z8ys9oTna89Y=
X-Gm-Gg: ASbGnctR7rhmLI3XGk/mMtfIMlKgH5jBQx7lPK/eXsGjRKVPoftIadnX+k/5Kvf4OwY
	Dc8eXD3kDPRv6O6NgCJazPjfFc+BqKbDMYOygdVdlsBhOrQSssfvtEmMIQ5QJ5pyAK/oIYQsF5Y
	63SmM8sNLc8+RyLFkyIHurE2UBMYPViIMy0kEE0RBwVW26uGPsmRtJgv5b1FtTkPO74JG1aUJ33
	BpOsYK9ONqgiG0oIck4c5OPiR3SPBzlGFUqM4sO9FstMr2Wp4wtUUtkoQlX1+zPENBLItkZbd3Y
	e/UeBXIpgsYErCIN+dnoA7hSarzyxSOT77bhRGJuzC3mlaBYvWLqfhbi8DxvBJcw/TRdUyUdGST
	8Sm/qI0JHs1qNyMZZXmnY4TajoC3zYc53fyeOaOqaU942m752XZ1KgZxIBTBih+Uslg==
X-Received: by 2002:a05:6214:319a:b0:87c:20b5:6685 with SMTP id 6a1803df08f44-87c20b56795mr9221876d6.55.1760631116561;
        Thu, 16 Oct 2025 09:11:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3K3iFq5m/T2G5n5k1Ub/AwaYH7OwwIxLCZt5EEaLCKub8NnH0J3P6LhBuV98s17jbVOVRfA==
X-Received: by 2002:a05:6214:319a:b0:87c:20b5:6685 with SMTP id 6a1803df08f44-87c20b56795mr9221106d6.55.1760631116071;
        Thu, 16 Oct 2025 09:11:56 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b4608sm42179536d6.58.2025.10.16.09.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 09:11:55 -0700 (PDT)
Date: Thu, 16 Oct 2025 12:11:53 -0400
From: Brian Masney <bmasney@redhat.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Iwona Winiarska <iwona.winiarska@intel.com>,
	Joel Stanley <joel@jms.id.au>, Maxime Ripard <mripard@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] peci: controller: peci-aspeed: convert from round_rate()
 to determine_rate()
Message-ID: <aPEZSY6RC-UVclxN@redhat.com>
References: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
 <aMatZAX6eFI1RmDH@redhat.com>
 <28dc3bd8aeca7e3164747960747f75060c596704.camel@codeconstruct.com.au>
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
In-Reply-To: <28dc3bd8aeca7e3164747960747f75060c596704.camel@codeconstruct.com.au>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nZhtqdSSNHpoBBt54-cCQmnGyltWztiArhVdMOac-Ro_1760631117
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrew and Iwona,

On Mon, Sep 15, 2025 at 02:36:48PM +0930, Andrew Jeffery wrote:
> Hi Brian,
> 
> On Sun, 2025-09-14 at 07:56 -0400, Brian Masney wrote:
> > Hi Iwona, Joel, and Andrew,
> > 
> > On Sun, Aug 10, 2025 at 06:21:51PM -0400, Brian Masney wrote:
> > > The round_rate() clk ops is deprecated, so migrate this driver from
> > > round_rate() to determine_rate() using the Coccinelle semantic patch
> > > appended to the "under-the-cut" portion of the patch.
> > > 
> > > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > 
> > Would it be possible to get this picked up for v6.18? I'd like to remove
> > this API from drivers/clk in v6.19.
> 
> My (strong) preference is that Iwona applies it, but I'll keep an eye
> out for any unusual delays.

This patch wasn't picked up for v6.18. Any chance this can get picked up
now for v6.19?

I'm hoping to get this merged so that we can remove the round_rate() clk
op from the clk core. The clk maintainer (Stephen) mentioned this work
in his last pull to Linus.

https://lore.kernel.org/linux-clk/20251007051720.11386-1-sboyd@kernel.org/

Thanks,

Brian


