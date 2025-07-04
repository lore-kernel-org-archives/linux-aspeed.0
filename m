Return-Path: <linux-aspeed+bounces-1634-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15917C83F03
	for <linux-aspeed@archiver.kernel.org>; Fri,  4 Jul 2025 14:46:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYc0P3qX2z30WS;
	Sat,  5 Jul 2025 00:46:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751640405;
	cv=none; b=NouxPJakotSlYdwnPI8YlimTFON7m2a1JolKKaFYovpNsT2yLZ0wDhpRQqywnM2zMH5N0FyJUS8ltkJqk6v6/xDmQg9VQ4SccVlm2R/sK5zPPdq94vNr+D47ul047mXgz3pt8nxfAz5lyfocdS3zvrthkntx9Q6Qi74+j6gfnBFaz3cOOVPmbGiHwp41q7tGXXXkQkt1xHuOxG0p0kn1qKV6HnWz54W5c5zxrwZWwpaJWU+aPEWerGrCcKuV5NmuoWw95CSTDQIpcBnU/2In6iaFCsQvf+UNSmfViw667cTMHahBDp2yWaFmC2gVGsrhuZrKLcSi0IHl2NYiItur/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751640405; c=relaxed/relaxed;
	bh=9frsXWKqJUycEBgjpx/MaijERGDr4YZunJ3meZeytu8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0yjjYc5i8RZHogxYNIZW0hoT3R+Cw9IiEXHlchueP83xp/VwWRDZ4ZdtM5QxbOHM8VsN9z9CDI1w2nUcEKG5VygesFA+ZjW1PdLpwvSzPXNlGerYlIO0NYs+HHJeUtCo2edAHrWNOI5J09YlVdymvyDZ8gcxEcJ419ypI+p0jHULMqLRQKTFtTgzztgdK8vT7S9hhqb3mhR+EXIlrpWRiod1YDS+G77YirweOYLU4xgTKCfFaeJyz6XzuMsMsNjqQxu1AMcMHunK3xDL/6mogGgDyx9joxZCR1Zs535903JdokAhuyDquo7HL8jYrsRVvkqwCcDQ6cvmZUKalDOFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MwoDi5jf; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PbRxcG5H; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MwoDi5jf; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PbRxcG5H; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jdelvare@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MwoDi5jf;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PbRxcG5H;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MwoDi5jf;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PbRxcG5H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jdelvare@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYc0M707kz30Vr
	for <linux-aspeed@lists.ozlabs.org>; Sat,  5 Jul 2025 00:46:43 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 80AE21F74A;
	Fri,  4 Jul 2025 14:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751640401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9frsXWKqJUycEBgjpx/MaijERGDr4YZunJ3meZeytu8=;
	b=MwoDi5jfNMsodAI3nT0YzR6nvL1Y9cRkMEjofNm9HKPW3caZHqykzpmA/5NA/ftgFRk6YN
	+wNSZ09IVl3Yicw1X9TgFliZ/76h4hAwSbjyk1A55R2koTDhHzoWf+D9fpY9LKtdWoUPgK
	yFrnvLKkh8nlLUHwTBblirGrs2elv7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751640401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9frsXWKqJUycEBgjpx/MaijERGDr4YZunJ3meZeytu8=;
	b=PbRxcG5H+BrclZAkVhcDcgKdloJq30AiW6NzL1KHqfXhkHjKadsmymhPSFfO2sllLg14Xm
	GGO1uZGHLgm053Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751640401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9frsXWKqJUycEBgjpx/MaijERGDr4YZunJ3meZeytu8=;
	b=MwoDi5jfNMsodAI3nT0YzR6nvL1Y9cRkMEjofNm9HKPW3caZHqykzpmA/5NA/ftgFRk6YN
	+wNSZ09IVl3Yicw1X9TgFliZ/76h4hAwSbjyk1A55R2koTDhHzoWf+D9fpY9LKtdWoUPgK
	yFrnvLKkh8nlLUHwTBblirGrs2elv7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751640401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9frsXWKqJUycEBgjpx/MaijERGDr4YZunJ3meZeytu8=;
	b=PbRxcG5H+BrclZAkVhcDcgKdloJq30AiW6NzL1KHqfXhkHjKadsmymhPSFfO2sllLg14Xm
	GGO1uZGHLgm053Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1330513A71;
	Fri,  4 Jul 2025 14:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SWC5AlHpZ2hgfQAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Fri, 04 Jul 2025 14:46:41 +0000
Date: Fri, 4 Jul 2025 16:46:37 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>, Henry
 Martin <bsdhenrymartin@gmail.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Andrew Geissler <geissonator@yahoo.com>,
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>,
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] soc: aspeed: lpc-snoop: Use dev_err_probe()
 where possible
Message-ID: <20250704164637.3552933a@endymion>
In-Reply-To: <20250616-aspeed-lpc-snoop-fixes-v2-8-3cdd59c934d3@codeconstruct.com.au>
References: <20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
	<20250616-aspeed-lpc-snoop-fixes-v2-8-3cdd59c934d3@codeconstruct.com.au>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,yahoo.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,jms.id.au,gmail.com,9elements.com,yahoo.com,linux.ibm.com,google.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,codeconstruct.com.au:email,suse.de:email]

On Mon, 16 Jun 2025 22:43:45 +0930, Andrew Jeffery wrote:
> Exploit that it returns the provided error to eliminate some lines, and
> return the actual error involved rather than -ENODEV.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> (...)

LGTM.

Acked-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

