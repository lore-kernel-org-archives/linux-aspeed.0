Return-Path: <linux-aspeed+bounces-3224-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A2FE784BE
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Dec 2025 01:50:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dffM45Ybnz2xdV;
	Mon, 29 Dec 2025 12:50:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766422839;
	cv=none; b=noKvvd7ONjG0edGEDdfm140QSaD+w+EsErK17drg1V37jA540RGTPm1CDMcjoRBDbSzM8wyQ4F4C2LrLXcCfbNMKJzTXlS4dV73cUZOTS0oqCKGlsUbn4U4ACLj8Uwa+o4fiiKnT++5KJ7M++Z9bRvmAWHEAOF9sGL6ShS/geAT7TtFZtJJ8bcBiQhDnbxatnd/QZZ/CQfUUZ71F4YukefxUtNSm+BVFCwUYdslopj8tS8zkHF4MzgM5SOl+VJrGjaTNNLvSddRMSOSYpcAkRo8I82lqb+7RI5uYrZbfzFuFPOFN0QxyiYLdZ40Wwjdj24oUEDZcUNSzUKXV9pLgVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766422839; c=relaxed/relaxed;
	bh=0f4fyk4zQd9fdm0CypX1izzvghVD+Nvn4s4UeRXutpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jnYEd3nevRH9ahNodbHgK4+GeuBMuNQsCA1THzVY2RVffNQn3z4kMicaAlQnnkcn4BCEe8IxmP0pV12QUmDuTXrnbG+H2S3C7LVoVbOxW+pfNIPhQpHSFhYALPgaQNH0fNfRw356TEX00Qkom+XNh6YfAUNg9NcfKvGdIcYCEs5So+Hlmz5LhNXl6vUOpnBB8ByfVj0sSOpCaCQHCeyaIjHOna9XVExuA1QVqn+dCEy3MNaSnpD5BfyPsDFNuRN8uEWFOEm+DuxCydulbQgSFqKAu/xbw/tObl20Q2vwjxJ1LJ9WwEzp7rNHjnqEAkin7BXeG0T9/uIOOnKoPu3rkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DynX/JLy; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aPdYfESu; dkim-atps=neutral; spf=temperror (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DynX/JLy;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aPdYfESu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=temperror (SPF Temporary Error: DNS Timeout) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (unknown [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZksx5HTYz2x99
	for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Dec 2025 04:00:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766422803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0f4fyk4zQd9fdm0CypX1izzvghVD+Nvn4s4UeRXutpY=;
	b=DynX/JLywm7WGzHdQeYUDFRE67wpzJImZS2RNXAvPtjf3hAcKq1y+ZsxJELoCwnv8V10DX
	W4seGhz+4taPvZrRd+H9dvyRUPrp4xF5UB2tgBwPNhkrmMjAw3lZD9zPqQn2YRCwPoZaoj
	/FsiHyjw+advtHQBisYYqyRH9WwP7Uc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766422804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0f4fyk4zQd9fdm0CypX1izzvghVD+Nvn4s4UeRXutpY=;
	b=aPdYfESu4Ua0cD30jqxifKFHBhd8zY26VhygqDBMKYgOzb9OF4/eTZPpI8/U+ArSDV73ff
	1PQ4O/+vvDSz8mlNnAE/+6oMosfHYiE0PUbN/j/5KcQ+D5L9ogk/aRCmQplw9vDFgdcyrX
	YM5InTzii/LGDYnLEut9Uu+09Me8Ew0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-O_ehSis9Mvu0SWJDVI2vsg-1; Mon, 22 Dec 2025 12:00:02 -0500
X-MC-Unique: O_ehSis9Mvu0SWJDVI2vsg-1
X-Mimecast-MFC-AGG-ID: O_ehSis9Mvu0SWJDVI2vsg_1766422801
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b24383b680so1374612885a.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Dec 2025 09:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766422801; x=1767027601;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0f4fyk4zQd9fdm0CypX1izzvghVD+Nvn4s4UeRXutpY=;
        b=fn2prxzwO0eWqn0Jj5aCrfXp/dvFOEFC6pkD5HvmgZboj9i/uL1wrA57uAth9LHpRB
         MqohadVwTeOZtZGulChOHa5JJzwrx1RO6T02ZzFP2plQgNcVbKtJqPfZKd9TqCQgrPYj
         PLlxq2U2mMP7EwvAjFsBQmzrzEkhdyeYwGnUPiPgCE2aGNgmLw+M+D0k81+Pc0pKiWa1
         ZnVryGkfPn0t7R0B+LTF4venEPOc+CsjBqE+m1DYQe9Cgi0RjlgTipidsUJxizwXM+U6
         j++lLczfpEgZuh1TofBZza8M/pMYCish8LLYPutpPPzXVOl7bRzv1z0A8wPBOsyCYi1f
         oHgw==
X-Forwarded-Encrypted: i=1; AJvYcCUxJ+ToK8/HICUFz4BPc4wshDSN9wtDjXHHmXUJa6WQhrlH6pUi/YuzlGWz1n9gcxXf/A9TXyX3Xaq8Lq8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyjndobJrNM+UdrC77Qwy2D5VsprDwleXMbwEPf1SN4VF+Kp/yu
	OxS0LvesCVqE6q94BfXN+Xf+IOQekGqthrWHKZ0nRQtbe+Y3rMm3qJVyJRs7uu3Ai1r66ILKEr/
	8syCiRoGXwPnwf6WbKh+CKCHnlwhhA4MtjnJCc2Qapzjii57MhJM71cmuaYfAjri5A2g=
X-Gm-Gg: AY/fxX7/SGwQe1jsBOiiBBozUIIaEpRhaicczbb+xnlVmQS+IeLWk/sEvR2olzHpsqx
	6bH4oA4cXbCcekFPXXVO+8QDnLB+POnYKN7LHTh9R57oucDX3ZsVFiE+FIKGjPpIC7o1MDXMUqx
	kM26uf1Vptr3Kv6wpYOveTyvrsE7wKiZNS3kwbiC2ABU3jHyLqIrPIBx8ETDSUm9nB0ocUXNjA9
	3VS7/WZspN/FXUVnXuzP4NLJWs5NCVCU3VijrytoDXskgzsBDgwSWgQT0ixYyHxQecoCZlkvirI
	lYE0Et/wPKW5CRhCiCdTipN89w28syH8NNopyHwFvWvDjwPDZEq8dykac25Qj/3Im6k46dU1afA
	hCkBHZFKoyEnNbZ/u1zz4VOpjDJt3E0QjpFHrmBoFIltP
X-Received: by 2002:a05:620a:691a:b0:8a3:22d7:6ca3 with SMTP id af79cd13be357-8c08f66c311mr1952380785a.31.1766422801390;
        Mon, 22 Dec 2025 09:00:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAXWK3aLK/w4OobjiC8eVjtvAbAxtwT1W5l5sKLlnUZ5at1LIDG+lvn7LFEDMGYJA0qFTMJw==
X-Received: by 2002:a05:620a:691a:b0:8a3:22d7:6ca3 with SMTP id af79cd13be357-8c08f66c311mr1952376385a.31.1766422800985;
        Mon, 22 Dec 2025 09:00:00 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d997addd5sm86399716d6.33.2025.12.22.08.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 09:00:00 -0800 (PST)
Date: Mon, 22 Dec 2025 11:59:56 -0500
From: Brian Masney <bmasney@redhat.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Mo Elbadry <elbadrym@google.com>,
	Rom Lemarchand <romlem@google.com>,
	William Kennington <wak@google.com>,
	Yuxiao Zhang <yuxiaozhang@google.com>,
	"wthai@nvidia.com" <wthai@nvidia.com>,
	"leohu@nvidia.com" <leohu@nvidia.com>,
	"dkodihalli@nvidia.com" <dkodihalli@nvidia.com>,
	"spuranik@nvidia.com" <spuranik@nvidia.com>
Subject: Re: [PATCH v15 3/3] clk: aspeed: add AST2700 clock driver
Message-ID: <aUl5DPMq8jC1xjRu@redhat.com>
References: <20251010072540.666673-1-ryan_chen@aspeedtech.com>
 <20251010072540.666673-4-ryan_chen@aspeedtech.com>
 <TY2PPF5CB9A1BE64DCD487138F3BAC4FD34F2FCA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
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
In-Reply-To: <TY2PPF5CB9A1BE64DCD487138F3BAC4FD34F2FCA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I7J6mfod5ilOR50zIcP0NR0jrmQel5xNPIH7VrFFeAg_1766422801
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ryan,

On Mon, Oct 27, 2025 at 06:24:59AM +0000, Ryan Chen wrote:
> Hello Stephen,
> 	Will this be accepted in clk-next?

Given that aspeed is a SoC vendor, and you already have multiple clk
drivers, I think at this point your best bet is to do what the other SoC
vendors currently do. I think you should:

- Create a new subdirectory drivers/clk/aspeed/
- Move the existing aspeed clk drivers into this subdirectory, and
  update the Makefiles / Kconfigs as appropriate.
- Add a new entry to the MAINTAINERS file for the aspeed clk drivers.
  You probably also want to have that entry cover the reset driver,
  and any other aspeed-specific drivers as well.
- Post that patch set. Include this new clk driver as a separate patch
  in that series. Feel free to CC me to the series and I'll review it
  for you.
- After it's reviewed, wait a week or two, and send Stephen a 
  'GIT PULL' using git request-pull. I can help you with the workflow
  if needed.
  
  One important detail is that you want to base your branch for the GIT
  PULL on the lowest common denominator, which is usually the latest rc1
  from Linus. So even if Linus is at rc5, try to base yours on rc1, unless
  there's some issue, and you need to document why. Stephen should get the
  merge to newer rcX branches from Linus, and not you.

When you send a PULL to Stephen, you can use 'b4 am' to assemble the
contents of your branch. When I sent him a PULL a few months ago, I
included the b4 commands that I used.

https://lore.kernel.org/all/aL8MXYrR5uoBa4cB@x1/

If he accepts the pull, you'll still need to post your patches to the
clk mailinglist, and have them reviewed on list. Folks from aspeed
should do that review publicly on the list.

Brian


