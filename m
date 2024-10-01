From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 1 Oct 2024 11:17:13 +0200
Subject: [PATCH v2 00/19] Migrate to sig_alg and templatize ecdsa
In-Reply-To: <cover.1725972333.git.lukas@wunner.de>
References: <cover.1725972333.git.lukas@wunner.de>
Message-ID: <Zvu-GV-vtDJHKf51@wunner.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Herbert,

On Tue, Sep 10, 2024 at 04:30:10PM +0200, Lukas Wunner wrote:
> The original impetus of this series is to introduce P1363 signature
> decoding for ecdsa (patch [18/19]), which is needed by the upcoming
> SPDM library (Security Protocol and Data Model) for PCI device
> authentication.
> 
> To facilitate that, move X9.62 signature decoding out of ecdsa.c and
> into a template (patch [15/19]).
> 
> New in v2:  Move the maximum signature size calculations for ecdsa
> out of software_key_query() and into the X9.62 template so that
> corresponding calculations can be added for P1363 without further
> cluttering up software_key_query() (patch [16/19] - [17/19]).
> 
> New in v2:  Avoid inefficient copying from kernel buffers to sglists
> in the new templates by introducing a sig_alg backend and migrating
> all algorithms to it, per Herbert's advice (patch [02/19] - [12/19]).
> 
> Clean up various smaller issues that caught my eye in ecdsa
> (patch [01/19] and [14/19]), ecrdsa (patch [19/19]) and
> ASN.1 headers (patch [13/19]).

This series was submitted at the tail end of the v6.11 cycle.
It still applies cleanly to v6.12-rc1 though, so I'm not sure
whether to resubmit.

Is there anything you want me to change?

Thanks!

Lukas
