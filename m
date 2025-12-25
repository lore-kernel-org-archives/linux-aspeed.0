Return-Path: <linux-aspeed+bounces-3211-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB15E784BE
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Dec 2025 01:41:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dff7m5Z3nz2xdV;
	Mon, 29 Dec 2025 12:41:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766684826;
	cv=none; b=VAybX2zd/cndRz+3klf73EnWbqq7Vu0KvhoUQzpYjXjDNUXt4Ivya3MDqv1/dGuzrV5zEN2n3Xz+oulHfI+TqNIsOAuklFFIbpFwqvlgu+tUgt09iiCzNLupoR14UuR04llJ+3+87ncDJwYSOomk/a/rbMnLDJW393l3LNhdsbmWgKgcyuBCrNcoRVbEFhgAKUvkXvC+YWpW+Dkqz+uP99E0yPlfHwOLMNiauON6n3ks+7zKGdB1FSfO9eVhBdp0IV2vFN/KZQnBRpPZvvFU8T+Tuu69iJzg+d89jMMmGmqYIkLCgi31a09+xivI8vGZqCZBrZZO9eGt6SPwAnwbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766684826; c=relaxed/relaxed;
	bh=zz1xVTvh572lJX2qZqJOG7cy24vvTwbo6dUFp/NuXtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=G3SCJuOujXEFGSPiPbWVn6sMBuXRSBbOEAXbYfH0HEpC236G41NcJLJ9fUYc3J6MSouI/vSEOYUHloIES1vTMzDmVegGWhUMPlqvPEwd+M3lUOLgkNlBOD3eGIL0g6RoIfgiSErYc0eXQC9ipQicZ0Lw62im2JJfRk6iOI/jhoSF0Ibw6qo2qfBUZhhZpy6BdV1KZsbqd71/jJAomjaB0dt8YNIu7RBuXCYIeeg2mu3OitFbd16FRDCg9OuAdxZ72zIybNqQ8ATSaRjV+NcXNyiKk7g1UIEeAfImPzzOYaE1rUT6MqDUsijM4B6I2kOkrwWHnoPogP1nnDSyEmzwfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X7MaSRV7; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X7MaSRV7; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X7MaSRV7;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X7MaSRV7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dcbm91fJJz2x99
	for <linux-aspeed@lists.ozlabs.org>; Fri, 26 Dec 2025 04:47:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766684822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zz1xVTvh572lJX2qZqJOG7cy24vvTwbo6dUFp/NuXtg=;
	b=X7MaSRV7TP2dmUlp1V1Nz3ufgbxK3LHtBRP3XeZnGFBK8XEvIbKxnracBknZdM3ZSDdTju
	ONsaEX79f85p6f1ta51gELvhfihiLn8caJWQCvFaLpoUaZfd7sUh2d4vyuxbdPZ0iiFFvU
	2oj+0+XKFJKXAJNzO+ljIECbvvLLho0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766684822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zz1xVTvh572lJX2qZqJOG7cy24vvTwbo6dUFp/NuXtg=;
	b=X7MaSRV7TP2dmUlp1V1Nz3ufgbxK3LHtBRP3XeZnGFBK8XEvIbKxnracBknZdM3ZSDdTju
	ONsaEX79f85p6f1ta51gELvhfihiLn8caJWQCvFaLpoUaZfd7sUh2d4vyuxbdPZ0iiFFvU
	2oj+0+XKFJKXAJNzO+ljIECbvvLLho0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-yTXMbBvPOzGtOGqBV6KYZg-1; Thu, 25 Dec 2025 12:45:19 -0500
X-MC-Unique: yTXMbBvPOzGtOGqBV6KYZg-1
X-Mimecast-MFC-AGG-ID: yTXMbBvPOzGtOGqBV6KYZg_1766684719
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b2e235d4d2so2476911185a.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 25 Dec 2025 09:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766684719; x=1767289519;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zz1xVTvh572lJX2qZqJOG7cy24vvTwbo6dUFp/NuXtg=;
        b=svMRtAp2+7xKW8/MjNLznrO5y1pLZ566idraLCknL/jG8lfnVtfJAZTY3msy3xO33Q
         y8YqI+PHXswPbODY9EqArULlu/gwYYggYu0BKRibwJwFv5pCQgW//V5KZ0eCiwi5a3vE
         s+QPhm03IE8kZf/h5rbjbjSwyZOyrTl0zzmenpN4NFveBp/JJikZtbyqIjyllbAzSO8F
         abshVJajF/jNXeAlWIThO7pS4HvWzaoJ1gTIz21sYoGzV2zWbtkteQt43fgxBA/Fk3i5
         tDz7MRAlzZb/mAazKCOHwSf44SCAePiMasffPVsBDnvnCKFHJ5Ex+o8qgExEk2vgfgPd
         SwhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVyeBp9eFEI/1fm1PcCG9Ebkb6c7Jq8sJKB9XDz1w7Zv0EVPonO9vRQdJN+KIaNrIMSRxmZkHWjylqKR4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzSZbUBtbRSQwJygM3ce42g4mJbdXvbmLWrEWs/w3L2r+RkqwAV
	J6A3DDAx4dfQWxSWW82pc+FL5j/ItgFXSDeyL8Za3XgYSZfxRuRwWUjxRarL07fcI8Y6cA0X08m
	3evSqMTIBC4JrXaq4Ymd3o2YIryNkSLGyXcQiqlRCKqhC96sAXE9hJEwNAkhTAGTIjyA=
X-Gm-Gg: AY/fxX4wEjGO+jqHY2fSvo2n2Cq4Q0Q6dg1qQwG5U70N2UYteNPU0qe27oC7nwx3a0R
	e0oon2ct2ug0AoAjr9hHwka7JdWf3aLFT0gnuzRXSqd2KYd0dHQqDgzzFkv1gQKn7GRTHCTiyhJ
	KAFnRgLX5wTR2lNt9GEpnLAOHq/nxkizHkPvtLylzQ2YArnQvm7GFWuykOB9CemTHp0J4Jbxhh2
	odBH/9Ndq7DavpUlWqx8vlae4GPLj1dBVZdg2f4o9THJU7LJ09sVfECK5IImV7itvUY1ZnJFQXK
	VatvWNHaHAif2ZT8YwbkULh/aOILntbqYfwTwADyqrGBo4vaY6voVd/Kzbda9Kr0D5kHZJggXDS
	9wyOA9oMbDBE5MeMQI5Ms4s9FIIFUTAt3DnlZ6ybrJUZ7
X-Received: by 2002:a05:620a:f13:b0:8b2:ef2d:f74b with SMTP id af79cd13be357-8c08f66bf3emr3080551485a.29.1766684719227;
        Thu, 25 Dec 2025 09:45:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/E6LsKwvfEMHC7uT4rrxVGLTNsXyb1jefziEMNS9y7ioMFDWn6jnZ3Lk+Vmjy/3v1Ei+vnA==
X-Received: by 2002:a05:620a:f13:b0:8b2:ef2d:f74b with SMTP id af79cd13be357-8c08f66bf3emr3080548585a.29.1766684718918;
        Thu, 25 Dec 2025 09:45:18 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d99d7dbdcsm151955716d6.43.2025.12.25.09.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 09:45:18 -0800 (PST)
Date: Thu, 25 Dec 2025 12:45:16 -0500
From: Brian Masney <bmasney@redhat.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v16 2/3] MAINTAINERS: Add entry for ASPEED clock drivers.
Message-ID: <aU14LCCn_Cnd8tV6@redhat.com>
References: <20251224-upstream_clk-v16-0-8c1318f56c3c@aspeedtech.com>
 <20251224-upstream_clk-v16-2-8c1318f56c3c@aspeedtech.com>
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
In-Reply-To: <20251224-upstream_clk-v16-2-8c1318f56c3c@aspeedtech.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EQII-Jg_uvK7g1k7yoltvmPs9a8cFWCoujN_iM-pCyg_1766684719
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 24, 2025 at 01:37:23PM +0800, Ryan Chen wrote:
> Add support entry for ASPEED clock drivers.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>


